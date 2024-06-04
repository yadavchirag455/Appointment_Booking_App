import 'dart:developer';
import 'package:appointment_app/pages/home.dart';
import 'package:appointment_app/pages/login.dart';
import 'package:appointment_app/services/database.dart';
import 'package:appointment_app/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _nameController = TextEditingController();
  final _gmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    // Check if the name contains only alphabetic characters and spaces
    final nameRegExp = RegExp(r'^[a-zA-Z ]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'Name can only contain alphabetic characters and spaces';
    }

    // Check for a minimum length (e.g., at least 2 characters)
    if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    }

    return null;
  }

  String? gmailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Basic email format validation
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Enter a valid Gmail address';
    }

    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    // Check if the password contains only digits and is at least 6 characters long
    final passwordRegExp = RegExp(r'^\d{6,}$');
    if (!passwordRegExp.hasMatch(value)) {
      return 'Password must be at least 6 digits long and contain only numbers';
    }

    return null;
  }

  // String? passwordValidator(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Password is required';
  //   }
  //
  //   // Check for minimum length
  //   if (value.length < 6) {
  //     return 'Password must be at least 6 characters long';
  //   }
  //
  //   // Check for at least one uppercase letter
  //   if (!RegExp(r'[A-Z]').hasMatch(value)) {
  //     return 'Password must contain at least one uppercase letter';
  //   }
  //
  //   // Check for at least one lowercase letter
  //   if (!RegExp(r'[a-z]').hasMatch(value)) {
  //     return 'Password must contain at least one lowercase letter';
  //   }
  //
  //   // Check for at least one digit
  //   if (!RegExp(r'\d').hasMatch(value)) {
  //     return 'Password must contain at least one digit';
  //   }
  //
  //   // Check for at least one special character
  //   if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
  //     return 'Password must contain at least one special character';
  //   }
  //
  //   return null;
  // }

  registraion() async {
    // if (_nameController.text.toString() != null &&
    //     _gmailController.text.toString() != null &&
    //     _passwordController.text.toString() != null) {
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _gmailController.text,
                password: _passwordController.text);

        String id = randomNumeric(5);

        await SharedPreferanceHelper().saveUserId(id);
        await SharedPreferanceHelper()
            .saveUserDisplayName(_nameController.text);
        await SharedPreferanceHelper().saveUserEmail(_gmailController.text);

        Map<String, dynamic> userInfoMap = {
          "Name": _nameController.text,
          "Email": _gmailController.text,
          "Password": _passwordController.text,
          "Id": id,
        };

        await Databasemethods().addUserDetails(userInfoMap, id);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Registraion done',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )));

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            'This Email is already used',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )));
        }
      }
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // backgroundColor: Color(0xff2b1615),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(children: [
            Container(
              padding: EdgeInsets.only(top: 50, left: 20),
              child: Text(
                'Hii \nCreate your account!',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFFB91635),
                Color(0xff621d3c),
                Color(0xFF311937)
              ])),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 40),
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(
                          color: Color(0xFFB91635),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      validator: nameValidator,
                      keyboardType: TextInputType.name,
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your Name',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      'Gmail',
                      style: TextStyle(
                          color: Color(0xFFB91635),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      validator: gmailValidator,
                      keyboardType: TextInputType.emailAddress,
                      controller: _gmailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your gmail',
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Password',
                      style: TextStyle(
                          color: Color(0xFFB91635),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      validator: passwordValidator,
                      keyboardType: TextInputType.number,
                      controller: _passwordController,
                      decoration: InputDecoration(
                        hintText: 'Enter your Password',
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.black45,
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Confirm Password',
                      style: TextStyle(
                          color: Color(0xFFB91635),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      validator: passwordValidator,
                      keyboardType: TextInputType.number,
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.black45,
                        ),
                      ),
                      obscureText: true,
                    ),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Text(
                    //       'Forgot Password?',
                    //       style: TextStyle(
                    //           color: Color(0xFF311937),
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.w500),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        log('tapped //  SignUp Button // Login Screen ');

                        log(_nameController.text);
                        log(_gmailController.text);
                        log(_passwordController.text);
                        log(_confirmPasswordController.text);

                        log('chaloooooo ho gaya');
                        if (_formKey.currentState!.validate()) {
                          registraion();
                        }

                        log('band ho gaya');
                        // Navigator.pushReplacement(context,
                        //     MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          // decoration: BoxDecoration(
                          //     color: Color(0xffdf711a),
                          //     borderRadius: BorderRadius.circular(20)),

                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(colors: [
                                Color(0xFFB91635),
                                Color(0xff621d3c),
                                Color(0xFF311937)
                              ])),
                          child: Center(
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            log('tapped //  SignIn Button // Login Screen ');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogIn()));
                          },
                          child: Text(
                            'Sign In!',
                            style: TextStyle(
                                color: Color(0xFF311937),
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          'Already have account?',
                          style: TextStyle(
                              color: Color(0xFF311937),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
