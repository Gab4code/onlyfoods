import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'food_details.dart';
import 'filter_options.dart';
import 'food_item.dart';

class Food {
  final String name;
  final String image;
  final String price;
  final int bookmarks;
  final String category;

  Food({required this.name, required this.image, required this.price, required this.bookmarks, required this.category});
}

class FoodGridView extends StatefulWidget {
  const FoodGridView({Key? key}) : super(key: key);

  @override
  State<FoodGridView> createState() => _FoodGridViewState();
}

class _FoodGridViewState extends State<FoodGridView> {
  List<Food>? data;
  List<Food> searchResults = [];
  Set<String> selectedFilters = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<Food> foods = [];

    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Kaon').get();

    snapshot.docs.forEach((doc) {
      foods.add(Food(
        name: doc['name'],
        image: doc['image_path'],
        price: doc['price'],
        bookmarks: doc['bookmarks'],
        category: doc['category']
      ));
    });
    //initial sort of food items
    foods.sort((a, b) => b.bookmarks.compareTo(a.bookmarks));

    setState(() {
      data = foods;
      searchResults = foods;
    });
  }

  void onQueryChanged(String query) {
    setState(() {
      searchResults = data!
          .where((food) =>
              food.name.toLowerCase().contains(query.toLowerCase()) ||
              food.image.toLowerCase().contains(query.toLowerCase()))
          .toList();
      searchResults.sort((a, b) => b.bookmarks.compareTo(a.bookmarks)); // Sort by bookmarks
    });
  }

  //takes the enabled/disabled filters in the filter popup
  void updateFilters(Set<String> filters) {
    setState(() {
      selectedFilters = filters;
      applyFilters();
    });
  }

  //updates searchResults (items) according to selectedFilters
  void applyFilters() {
    if (selectedFilters.isEmpty) {
      searchResults = data!;
    } else {
      searchResults = data!.where((food) {
        for (var filter in selectedFilters) {
          if (food.category.toLowerCase().contains(filter.toLowerCase())) {
            return true;
          }
        }
        return false;
      }).toList();
    }
    //final sort of items to be displayed
    searchResults.sort((a, b) => b.bookmarks.compareTo(a.bookmarks));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(25.0),
                  shadowColor: Colors.grey.withOpacity(0.5),
                  child: SearchBar(onQueryChanged: onQueryChanged),
                ),
              ),
              IconButton(
                icon: Icon(Icons.filter_list, color: Color(0xFF01a990)),
                onPressed: () async {
                  final filters = await FilterOptions.show(context, selectedFilters);
                  if (filters != null) {
                    updateFilters(filters);
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Popular',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'Poppins',
                color: Color(0xFF01a990),
              ),
            ),
           ),
        ),
        //
        Wrap(
          spacing: 8.0,
          children: selectedFilters
              .map((filter) => Chip(
                    backgroundColor: Color(0xFF01a990),
                    label: Text(filter, style: TextStyle(color: Colors.white),),
                    onDeleted: () {
                      setState(() {
                        selectedFilters.remove(filter);
                        applyFilters();
                      });
                    },
                  ))
              .toList(),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              return FoodItem(
                name: searchResults[index].name,
                image: searchResults[index].image ,
                price: searchResults[index].price,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodDetailPage(
                        name: searchResults[index].name,
                        image: searchResults[index].image,
                        price: searchResults[index].price,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onQueryChanged;

  const SearchBar({Key? key, required this.onQueryChanged}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: TextField(
        onChanged: widget.onQueryChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Color(0xFF01a990)),
          hintText: 'What are you craving?',
          hintStyle: TextStyle(
            color: Colors.grey.withOpacity(0.5),
            fontStyle: FontStyle.italic,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.5),
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
