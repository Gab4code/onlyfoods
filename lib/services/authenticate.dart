import 'package:flutter/material.dart';
import 'package:onlyfoods/screens/login_page.dart';
import 'package:onlyfoods/screens/register_page.dart';

class Authenticate_Page extends StatefulWidget {
  const Authenticate_Page({super.key});

  @override
  State<Authenticate_Page> createState() => _Authenticate_PageState();
}

class _Authenticate_PageState extends State<Authenticate_Page> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn == true) {
      //You need to pass the function as parameter to the stateful widget
      return loginPage(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
