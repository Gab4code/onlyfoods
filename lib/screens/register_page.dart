import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:onlyfoods/screens/homepage/home_page.dart';
import 'package:onlyfoods/services/auth_page.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  State<Register> createState() => _registrationState();
}

class _registrationState extends State<Register> {

  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String confirmPassword = '';
  String username = '';
  String error = '';
  String bday = '';
  String fcolor = '';

  String selectedColorLevel = '';
  String colorValue = 'Choose a color';
  var colorLevels = [
    'Choose a color',
    'red',
    'green',
    'blue',
  ];



  TextEditingController dateInput = TextEditingController();

  final AuthService _auth = AuthService();
  
  String? _errorMessage;
  void _handleRegisterError(String errorMessage) {
    setState(() {
      _errorMessage =
          errorMessage.replaceAllMapped(RegExp(r'\[[^\]]*\]'), (match) {
        return ''; // Replace the matched content with an empty string
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Create your Account",
                style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 10), 
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your Username',
                      prefixIcon: Icon(Icons.account_circle),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black
                    ),
                    // validate if empty
                    validator: (val) =>
                      val!.isEmpty ? "Enter your Username" : null ,
                    onChanged: (val) {
                      print(username);
                      setState(() => username = val);
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 10), 
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black
                    ),
                    // validate if empty
                    validator: (val) =>
                      val!.isEmpty ? "Enter your Email" : null ,
                    onChanged: (val) {
                      print(email);
                      setState(() => email = val);
                    },
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 10), 
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icon(Icons.security),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black
                    ),
                    // validate if empty
                    validator: (val) =>
                      val!.length < 6 ? "Enter a password 6+ Characters long" : null ,
                    onChanged: (val) {
                      //print(password);
                      setState(() => password = val);
                    },
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 10), 
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Confirm your password',
                      prefixIcon: Icon(Icons.security),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.black
                    ),
                    // validate if empty
                    validator: (val) =>
                      val != password ? "Password do not match" : null ,
                    onChanged: (val) {
                      //print(password);
                      setState(() => confirmPassword = val);
                    },
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 20.0),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller: dateInput,
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Enter Birthdate",
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2100),
                        );
        
                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          setState(() {
                            dateInput.text = formattedDate;
                            bday = formattedDate;
                          });
                        }
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 110),
                      child: DropdownButton(
                        value: colorValue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 83, 98, 93), fontSize: 17),
                        items: colorLevels.map((String coloritem) {
                          return DropdownMenuItem(
                            value: coloritem,
                            child: Text(coloritem),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          print(colorValue);
                          setState(() {
                            colorValue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple),
                  child: Text("Register", style:  TextStyle(color: Colors.white),),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                        email,
                        username,
                        confirmPassword,
                        bday,
                        colorValue,
                        _handleRegisterError,
                      );
                      print('Register Successful');
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => homePage(),));
      
                      if (result == null) {
                        setState(() {
                          error = _errorMessage!;
                        });
                      }
                    }
                    
                  },
                )
              ],
            ),   
          ),
        ), 
      ),
    );
  }
}

