import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodDetailPage extends StatelessWidget {
  final String name;
  final String image;
  final String price;

  FoodDetailPage(
      {required this.name, required this.image, required this.price});

  late Size mediaSize;

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 155, 2, 2),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.network(
              image,
              fit: BoxFit.cover,
              height: mediaSize.height * 0.4, 
            ),
          ),
          Positioned(
            bottom: 0,
            child: _buildBottom(),
          ),
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      height: mediaSize.height * 0.55,
      child: Card(
        color: const Color.fromARGB(255, 255, 245, 245),
        shadowColor: Colors.black87,
        elevation: 50,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _buildInfo(),
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Text(
          name,
          style: GoogleFonts.poppins(
              textStyle: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            color: Colors.black, // Change the color here
          )),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.currency_ruble,
                size: 30, color: Color.fromARGB(255, 155, 2, 2)),
            SizedBox(width: 5),
            Text(
              price,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 155, 2, 2),
              )),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.store, size: 30, color: Color.fromARGB(255, 155, 2, 2)),
            SizedBox(width: 5),
            Text(
              'Establishment: ',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black, 
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.location_on,
                size: 30, color: Color.fromARGB(255, 155, 2, 2)),
            SizedBox(width: 5),
            Text(
              'Location: ',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black, // Change the color here
              )),
            ),
          ],
        ),
      ],
    );
  }
}
