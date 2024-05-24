import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'food_details.dart';
import '../../test_team_files/filter_options.dart';
import 'food_item.dart';

class Food {
  final String name;
  final String image;
  final String price;

  Food({required this.name, required this.image, required this.price});
}


class FoodGridView extends StatefulWidget {
  const FoodGridView({Key? key}) : super(key: key);

  @override
  State<FoodGridView> createState() => _FoodGridViewState();
}


class _FoodGridViewState extends State<FoodGridView> {
  late List<Food>? data;

  List<Food> searchResults = [];

  @override
  void initState(){
    super.initState();
    fetchData();
  }

void fetchData() async {
  List<Food> foods = [];

  QuerySnapshot snapshot1 = await FirebaseFirestore.instance
    .collection('Kaon')
    .get();

  snapshot1.docs.forEach((doc) {
    foods.add(Food(name: doc['name'], image: doc['image_path'], price: doc['price']));
   });

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
      //Sort the searchResults based on price
      searchResults.sort((a, b) => double.parse(a.price).compareTo(double.parse(b.price)));
    });
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
                onPressed: () {
                  FilterOptions.show(context); // Call the show method to display filter options
                },
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12.0), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Popular',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    color: Color(0xFF01a990),
                  ),
                ),
                SizedBox(height: 1), 
              ],
            ),
          ),
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
                image: searchResults[index].image+".jpg",
                price: searchResults[index].price,
                onTap: () {
                  // Handle on tap food here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodDetailPage(
                        name: searchResults[index].name,
                        image: searchResults[index].image+".jpg",
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