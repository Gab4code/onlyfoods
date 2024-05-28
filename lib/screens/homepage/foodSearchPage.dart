import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onlyfoods/screens/homepage/food_grid_view.dart';
import 'package:onlyfoods/screens/homepage/bookmark.dart';

class foodPage extends StatefulWidget {
  const foodPage({Key? key}) : super(key: key);

  @override
  State<foodPage> createState() => _foodPageState();
}

class _foodPageState extends State<foodPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;


  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    FoodGridView(),
    BookmarkedFoods(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'OnlyFoods',
          style: TextStyle(color: Color.fromARGB(255, 155, 2, 2), fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 155, 2, 2)),
      ),
      drawer: Drawer(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(currentUser.email)
            .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final userData = snapshot.data!;
              final displayName = userData['username'] ?? 'User Name';
              final email = userData['email'] ?? 'user.email@example.com';
              return ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text(
                      displayName,
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    accountEmail: Text(
                      email,
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 155, 2, 2),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title:
                        Text('Logout', style: TextStyle(fontFamily: 'Poppins')),
                    onTap: () {
                      // Handle logout tap here
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, size: 30),
            label: 'Bookmarks',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFDF0000),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedLabelStyle:
            TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedIconTheme: IconThemeData(color: Color(0xFFDF0000)),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
      ),
    );
  }
}
