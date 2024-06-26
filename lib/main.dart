import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onlyfoods/screens/homepage/home_page.dart';
import 'package:onlyfoods/test_team_files/map_page.dart';
import 'package:onlyfoods/screens/login_page.dart';
import 'package:onlyfoods/screens/register_page.dart';
import 'package:onlyfoods/services/wrapper.dart';
import 'screens/onboarding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: 
      // MapPage()
      Onboarding(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Final Project',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: Onboarding(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});


//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//  @override
//  Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(title: Center(child: Text("OnlyFoods",style: TextStyle(color: Colors.white),)),
//     backgroundColor: Colors.purple,),
//     body: Wrapper()
//   );
//  }
// }