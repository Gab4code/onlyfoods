// Scaffold(
    //   appBar: AppBar(title: Text('Profile Screen',style: TextStyle(color: Colors.white),),
    //   backgroundColor: Colors.purple,
    //   ),
    //   body: StreamBuilder<DocumentSnapshot>(
    //     stream: FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(currentUser.email)
    //     .snapshots(),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       final userData = snapshot.data!.data() as Map<String, dynamic>;

    //       final favoriteColor = userData['fcolor'];

    //       return Container(
    //         color: getColorFromName(favoriteColor),
    //         child: Column(
    //           children: [
            
    //                       Center(
    //                         child: Image.network(
    //                                 'https://media1.tenor.com/m/SmQiEMC3gWEAAAAC/mapache-pedro-p%C3%A9.gif',
    //                                 width: 150,
    //                                 height: 150,
                                  
    //                               ),
    //                       ),
                        
            
    //             Text('Username: ' + userData['username'],style: TextStyle(color: Colors.white),),
    //             SizedBox(height: 5.0),
    //             Text('Birthdate: ' + userData['birthdate'],style: TextStyle(color: Colors.white)),
    //             SizedBox(height: 5.0,),
    //             Text('Favorite Color : ' + userData['fcolor'],style: TextStyle(color: Colors.white)),
    //           ],
    //         ),
    //       );
    //     } 







    //     else if (snapshot.hasError) {
    //       return Center(child: Text('Error${snapshot.error}'),);
    //     }

    //     return const Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    //   ),
    // );