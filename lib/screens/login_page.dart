import 'package:flutter/material.dart';
import 'package:onlyfoods/screens/homepage/home_page.dart';
import 'package:onlyfoods/screens/register_page.dart';
import 'package:onlyfoods/services/auth_page.dart';
import 'package:onlyfoods/services/wrapper.dart';

class loginPage extends StatefulWidget {
  final Function toggleView;
  const loginPage({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<loginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<loginPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  late Color myColor;
  late Size mediaSize;
  bool _isObscure = true;
  
   @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration:BoxDecoration(
        image:DecorationImage( 
          image:NetworkImage('https://i.pinimg.com/564x/21/45/ac/2145ac8af61a4b9f8144823d104da4ae.jpg'),
          fit:BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2), 
                BlendMode.darken,
              ),
            )
          ) ,   
          child:Scaffold( 
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

  Widget _buildTop(){
    return SizedBox(
      width:mediaSize.width,
      child:const Column( 
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 250), 
            child:
            Image(
              image: AssetImage('lib/images/Logo_white.png'),
            ),   
          )
        ]
    )
  );
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
             )
          ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _buildForm(),
         ),
      ),
    );
  }

   Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Welcome",
          style: TextStyle(
              color: Color(0xFFDF0000), fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Please sign in with your information",
          style: TextStyle(
              color: Colors.black,
        ),
        ),
        const SizedBox(height: 25),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child:
          TextFormField(
          decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'Enter your Email',
              labelStyle: TextStyle(color: Color(0xFF595959)),
              prefixIcon: Icon(Icons.email, color: Color(0xFFDF0000)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Color(0xFFDF0000)),
              ),
            ),
              style: const TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 57, 57, 57),
                  fontFamily: 'Poppins',
                  ),
              validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
                  onChanged: (val) {
                      setState(() => email = val);
                    },
              ),
          ),
          Padding(
          padding: EdgeInsets.symmetric(horizontal:5, vertical:5),
          child:
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your Password',
              labelStyle: TextStyle(color: Color(0xFF595959)),
              prefixIcon: Icon(Icons.lock, color: Color(0xFFDF0000)),
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
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),                      
                  ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(color: Color(0xFFDF0000)),
                ),
              ),
              style: const TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 57, 57, 57),
                  fontFamily: 'Poppins',
                ),
              validator: (val) => val!.length < 6 ? 'Enter a Password with 6+ Chars long' : null,
                  onChanged: (val) {
                      setState(() => password = val);
                    },
              ),
            ),
            const SizedBox(height: 15,),
            Padding(
            padding: EdgeInsets.only(left: 15),
            child:
              SizedBox(
                  width: 300,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth.signInWithEmailAndPassword(
                          email,
                          password,
                        );
                        if (result == null) {
                          
                          setState(() => error = 'credentials are not valid.');
                        }
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => homePage(),));
                        
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFDF0000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        
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
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
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
                      child: Text(
                        " Sign up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Color.fromARGB(255, 240, 41, 6),
                        ),
                      ),
                    ),
                  ],
                ),
                                
      ]
    );
   }

   
    
        
}   
