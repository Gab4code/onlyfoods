import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onlyfoods/screens/homepage/home_page.dart';
import 'package:onlyfoods/screens/login_page.dart';
import 'package:onlyfoods/services/auth_page.dart';
import 'package:onlyfoods/services/authenticate.dart';
import 'package:google_fonts/google_fonts.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _registrationState();
}

class _registrationState extends State<Register> {
  late Color myColor;
  late Size mediaSize;
  bool _isObscure = true;
  bool _isObscure1 = true;
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String confirmPassword = '';
  String username = '';
  String error = '';
  //String bday = '';

  TextEditingController dateInput = TextEditingController();

  final AuthService _auth = AuthService();

  String? _errorMessage;
  void _handleRegisterError(String errorMessage) {
    setState(() {
      _errorMessage =
          errorMessage.replaceAllMapped(RegExp(r'\[[^\]]*\]'), (match) {
        return '';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(
            'https://i.pinimg.com/564x/21/45/ac/2145ac8af61a4b9f8144823d104da4ae.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.2),
          BlendMode.darken,
        ),
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: _buildTop(),
              ),
              Positioned(
                bottom: 0,
                child: _buildBottom(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
        width: mediaSize.width,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              children: [
                BackButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Authenticate_Page()),
                    );
                  },
                ),
                Spacer(),
                SizedBox(
                  width: 120,
                  height: 120,
                  child: const Image(
                    image: AssetImage('lib/images/Logo_white.png'),
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 30),
              ],
            ),
          )
        ]));
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        color: Color.fromARGB(255, 255, 253, 242),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        )),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "Create an account",
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 155, 2, 2),
        )),
      ),
      Text(
        "Please sign up with your information",
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
          color: Colors.black,
        )),
      ),
      const SizedBox(height: 20),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Username',
              hintText: 'Enter your Username',
              labelStyle: TextStyle(color: Color(0xFF595959)),
              prefixIcon: Icon(Icons.account_circle,
                  color: Color.fromARGB(255, 155, 2, 2)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Color.fromARGB(255, 155, 2, 2)),
              ),
            ),
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 57, 57, 57),
            )),
            validator: (val) => val!.isEmpty ? "Enter your Username" : null,
            onChanged: (val) {
              print(username);
              setState(() => username = val);
            }),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email',
            labelStyle: TextStyle(color: Color(0xFF595959)),
            prefixIcon: Icon(Icons.mail, color: Color.fromARGB(255, 155, 2, 2)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Color.fromARGB(255, 155, 2, 2)),
            ),
          ),
          style: GoogleFonts.poppins(
                textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 57, 57, 57),
            )),
          validator: (val) => val!.isEmpty ? "Enter your Email" : null,
          onChanged: (val) {
            print(email);
            setState(() => email = val);
          },
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Enter your password',
            labelStyle: TextStyle(color: Color(0xFF595959)),
            prefixIcon:
                Icon(Icons.security, color: Color.fromARGB(255, 155, 2, 2)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Color.fromARGB(255, 155, 2, 2)),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility : Icons.visibility_off,
                color: Color.fromARGB(255, 155, 155, 155),
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
          ),
          style: GoogleFonts.poppins(
                textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 57, 57, 57),
            )),
          obscureText: _isObscure,
          validator: (val) =>
              val!.length < 6 ? "Enter a password 6+ Characters long" : null,
          onChanged: (val) {
            //print(password);
            setState(() => password = val);
          },
          //obscureText: true,
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            hintText: 'Confirm your password',
            labelStyle: TextStyle(color: Color(0xFF595959)),
            prefixIcon:
                Icon(Icons.security, color: Color.fromARGB(255, 155, 2, 2)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Color.fromARGB(255, 155, 2, 2)),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _isObscure1 ? Icons.visibility : Icons.visibility_off,
                color: Color.fromARGB(255, 155, 155, 155),
              ),
              onPressed: () {
                setState(() {
                  _isObscure1 = !_isObscure1;
                });
              },
            ),
          ),
          style: GoogleFonts.poppins(
                textStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 57, 57, 57),
            )),
          obscureText: _isObscure1,
          validator: (val) => val != password ? "Password do not match" : null,
          onChanged: (val) {
            //print(password);
            setState(() => confirmPassword = val);
          },
          //obscureText: true,
        ),
      ),
      SizedBox(height: 10.0),
      Padding(
        padding: EdgeInsets.only(left: 15),
        child: SizedBox(
          width: 300,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 155, 2, 2)),
            child: Text(
              "Sign Up",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            )),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                dynamic result = await _auth.registerWithEmailAndPassword(
                  email,
                  username,
                  confirmPassword,
                  //bday,
                  _handleRegisterError,
                );
                print('Register Successful');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => homePage(),
                    ));

                // if (result == null) {
                //   setState(() {
                //     error = _errorMessage!;
                //   });
                // }
              }
            },
          ),
        ),
      ),
    ]);
  }
}