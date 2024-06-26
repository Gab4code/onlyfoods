import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onlyfoods/screens/homepage/food_details.dart';
import 'package:google_fonts/google_fonts.dart';

class BookmarkedFoods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser!.email;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser)
          .collection('bookmarks')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No bookmarks yet'));
        }

        final bookmarks = snapshot.data!.docs;

        return ListView.builder(
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            final bookmark = bookmarks[index];
            final name = bookmark['name'];
            final price = bookmark['price'];
            final image = bookmark['image'];
            final vendor = bookmark['vendor'];
            final location = bookmark['location'];
            final address = bookmark['address'];

            return GestureDetector(
              onTap: () {
                // Navigate to food details or perform another action
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodDetailPage(
                      name: name,
                      price: price,
                      image: image,
                      vendor: vendor,
                      location: LatLng(location.latitude, location.longitude),
                      address: address,
                      // add other necessary fields
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: 15.0, right: 15.0, bottom: 10.0, top: 10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 155, 2, 2), width: 1.0),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  title: Text(
                    name,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  subtitle: Text(price,
                  style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 79, 78, 78),
                ),
              ),),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete,
                            color: Color.fromARGB(255, 155, 2, 2)),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                'Confirm Deletion',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              content: Text(
                                'Are you sure you want to delete this bookmark?',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: Text(
                                    'Cancel',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Color.fromARGB(255, 155, 2, 2),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Delete',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Color.fromARGB(255, 155, 2, 2),
                                      ),
                                    ),
                                  ),
                                    onPressed: () async {
  final documentId = bookmark.id; // Assuming bookmark is the document snapshot

  await FirebaseFirestore.instance.runTransaction((transaction) async {
    final bookmarkRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser)
        .collection('bookmarks')
        .doc(documentId);

    final bookmarkDestRef = FirebaseFirestore.instance
        .collection('Kaon')
        .doc(documentId);

    transaction.delete(bookmarkRef);

    transaction.update(bookmarkDestRef, {
      'bookmarks': FieldValue.increment(-1),
    });
  });

  Navigator.pop(context);
}
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// class FoodDetailPage extends StatelessWidget {
//   final String name;
//   final String price;
//   final String image;
//   // Add other necessary fields

//   const FoodDetailPage({required this.name, required this.price, required this.image});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(name),
//       ),
//       body: Center(
//         child: Text('Food details go here'),
//       ),
//     );
//   }
// }
