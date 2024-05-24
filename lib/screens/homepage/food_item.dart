import 'package:flutter/material.dart';

class FoodItem extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final VoidCallback onTap;

  FoodItem({required this.name, required this.image, required this.price, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
              child: 
              // Container(
              //   height: 120,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('assets/images/burger.jpg'),
              //       fit: BoxFit.cover
              //     )
              //   ),
              // )
              
              
              
              Image.asset(
                image,
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
              child: Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(price, style: TextStyle(color: Colors.white70)),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // Handle on tap bookmark here
                    },
                    child: Icon(Icons.favorite_border, color: Colors.white70),
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