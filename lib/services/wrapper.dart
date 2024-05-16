
import 'package:flutter/material.dart';
import 'package:onlyfoods/screens/home_page.dart';
import 'package:onlyfoods/services/authenticate.dart';
import 'package:onlyfoods/services/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    if (user == null) {
      return Authenticate_Page();
    } else {
      return homePage();
    }
  }
}




