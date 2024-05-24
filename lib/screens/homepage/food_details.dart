import 'package:flutter/material.dart';

class FoodDetailPage extends StatelessWidget {
  final String name;
  final String image;
  final String price;

  FoodDetailPage({required this.name, required this.image, required this.price});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: TextStyle(color: Color(0xFF01a990), fontFamily: 'Poppins')),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xFF01a990)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: 

              Image.asset(
                image,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: Colors.grey,
                    child: Center(child: Text('Image not found')),
                  );
                },
              ),
              
              // Container(
              //   height: 200,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       image: AssetImage('assets/images/burger.jpg'),
              //       fit: BoxFit.cover
              //     )
              //   ),
              // )
            ),
            SizedBox(height: 16),
            Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, fontFamily: 'Poppins')),
            SizedBox(height: 8),
            Text(price, style: TextStyle(color: Colors.grey, fontSize: 20, fontFamily: 'Poppins')),
            SizedBox(height: 16),
            Text(
              'This is burger',
              style: TextStyle(fontSize: 16, fontFamily: 'Poppins'),
            ),
          ],
        ),
      ),
    );
  }
}
