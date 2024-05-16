import 'package:flutter/material.dart';
import 'package:onlyfoods/screens/home_page.dart';
import 'package:onlyfoods/screens/register_page.dart';
import 'package:onlyfoods/services/auth_page.dart';

class loginPage extends StatefulWidget {
  final Function toggleView;
  const loginPage({super.key, required this.toggleView});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();


  String email = '';
  String password = '';
  String error = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.person, size: 150,),
              SizedBox(height: 20,),
              Text("Login / Sign In Here",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold)),
              SizedBox(height: 20,),
              Padding(padding: 
                EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
                  onChanged: (val) {
                      setState(() => email = val);
                    },
                ),
              ),
              Padding(padding: 
                EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  validator: (val) => val!.length < 6 ? 'Enter a Password with 6+ Chars long' : null,
                  onChanged: (val) {
                      setState(() => password = val);
                    },
                ),
              ),
            const SizedBox(height: 20),
            SizedBox(
                  width: 300,
                  height: 34,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth.signInWithEmailAndPassword(
                          email,
                          password,
                        );
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => homePage(),));
                        if (result == null) {
                          setState(() => error = 'credentials are not valid.');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Register(
                          toggleView: () {},
                        ),
                      ),
                    );
                  },
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: TextStyle(
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
}