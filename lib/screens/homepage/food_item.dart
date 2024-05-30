import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodItem extends StatefulWidget {
  final currentUser = FirebaseAuth.instance.currentUser!;

  final String name;
  final String image;
  final String price;
  final String vendor;
  final GeoPoint location;
  final String address;
  final String uid;
  final VoidCallback onTap;

  FoodItem({
    required this.name,
    required this.image,
    required this.price,
    required this.onTap,
    required this.vendor,
    required this.location,
    required this.address,
    required this.uid,
  });

  @override
  _FoodItemState createState() => _FoodItemState();
}

class _FoodItemState extends State<FoodItem> {
  bool isBookmarked = false;
  String? documentId;

  @override
  void initState() {
    super.initState();
    _initializeBookmark();
  }

  void _initializeBookmark() async {
    final docId = await _getDocumentIdByUid(widget.uid);
    if (docId != null) {
      setState(() {
        documentId = docId;
      });
      _checkBookmarkStatus(docId);
    }
  }

  Future<String?> _getDocumentIdByUid(String uid) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('Kaon')
      .where('uid', isEqualTo: uid)
      .limit(1)
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    return querySnapshot.docs.first.id;
  }
  return null;
}

  void _checkBookmarkStatus(String docId) async {
    final user = FirebaseAuth.instance.currentUser!.email;
    final doc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user)
        .collection('bookmarks')
        .doc(docId)
        .get();
     if (doc.exists) {
      // Check if the uid in the document matches
      final bookmarkData = doc.data();
      if (bookmarkData != null && bookmarkData['uid'] == widget.uid) {
        setState(() {
          isBookmarked = true;
        });
      } else {
        setState(() {
          isBookmarked = false;
        });
      }
    } else {
      setState(() {
        isBookmarked = false;
      });
    }
  }

  void toggleBookmark() async {
    if (documentId == null) return;

    final user = FirebaseAuth.instance.currentUser!.email;

    final bookmarkDest = FirebaseFirestore.instance
        .collection('Kaon')
        .doc(documentId);

    final bookmarkRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(user)
        .collection('bookmarks')
        .doc(documentId);

    final batch = FirebaseFirestore.instance.batch();

    if (isBookmarked) {
      // FROM BOOKMARKED - NON-BOOKMARKED
      batch.delete(bookmarkRef);
      batch.update(bookmarkDest, {
        'bookmarks': FieldValue.increment(-1),
      });
    } else {
      // FROM NON-BOOKMARKED - BOOKMARKED
      batch.set(bookmarkRef, {
        'name': widget.name,
        'image': widget.image,
        'price': widget.price,
        'vendor': widget.vendor,
        'location': widget.location,
        'address': widget.address,
        'uid':widget.uid
      });
      batch.update(bookmarkDest, {
        'bookmarks': FieldValue.increment(1),
      });
    }

    await batch.commit();

    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 155, 2, 2),
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
              child: Text(
                widget.name,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                widget.price,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    //fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 219, 218, 218),
                  ),
                ),
              ),
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
                      color: Color.fromARGB(255, 228, 90, 90),
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
