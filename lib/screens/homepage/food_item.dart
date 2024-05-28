import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FoodItem extends StatefulWidget {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final String name;
  final String image;
  final String price;
  final VoidCallback onTap;

  FoodItem({required this.name, required this.image, required this.price, required this.onTap});

  @override
  _FoodItemState createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  bool isBookmarked = false;

   @override
  void initState() {
    super.initState();
    _checkBookmarkStatus();
  }


  void _checkBookmarkStatus() async {
    final user = FirebaseAuth.instance.currentUser!.email;
    final doc = await FirebaseFirestore.instance
      .collection('Users')
      .doc(user)
      .collection('bookmarks')
      .doc(widget.name)
      .get();
    setState(() {
      isBookmarked = doc.exists;
    });
  }


  void toggleBookmark() async {
    final user = FirebaseAuth.instance.currentUser!.email;

    final bookmarkDest = FirebaseFirestore.instance
      .collection('Kaon')
      .doc(widget.name);



    final bookmarkRef = FirebaseFirestore.instance
      .collection('Users')
      .doc(user)
      .collection('bookmarks')
      .doc(widget.name);

      final batch = FirebaseFirestore.instance.batch();


      if(isBookmarked) {
        //FROM BOOKMARKED - NON-BOOKMARKED
        batch.delete(bookmarkRef);
        batch.update(bookmarkDest, {
        'bookmarks': FieldValue.increment(-1),
      });
      }
      else {
        //FROM NON-BOOKMARKED - BOOKMARKED
        batch.set(bookmarkRef, 
          {
            'name':widget.name,
            'image':widget.image,
            'price':widget.price
          }
        );
        batch.update(bookmarkDest, {
          'bookmarks': FieldValue.increment(1),
        });
      }

      await batch.commit();


    setState(() {
      isBookmarked = !isBookmarked;
    });
    // Optionally, handle other bookmark-related logic here, like updating a database
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF01a990),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.network(
                widget.image,
                fit: BoxFit.cover, 
                height: 120,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: Colors.grey,
                    child: Center(child: Text('Image not found')),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(widget.price, style: TextStyle(color: Colors.white70)),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: toggleBookmark,
                    child: Icon(
                      isBookmarked ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
