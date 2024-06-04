import 'dart:developer';
import 'package:appointment_app/admin/admin_login.dart';
import 'package:appointment_app/pages/forgot_password.dart';
import 'package:appointment_app/pages/home.dart';
import 'package:appointment_app/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _gmailController = TextEditingController();
  final _passwordController = TextEditingController();

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

  userLogin() async {
    log('Login Function is called');

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _gmailController.text, password: _passwordController.text);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        'Login Succefully',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('no user foundddddddd');

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'No user Found on this Email',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )));
      } else if (e.code == 'wrong-password') {
        log('wrong password');

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Wrong Password',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'An error occurred. Please try again.',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )));
      }
    }
  }

  final _formKey2 = GlobalKey<FormState>();
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
                'Hello \nCustomer!',
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
                key: _formKey2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Gmail',
                      style: TextStyle(
                          color: Color(0xFFB91635),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      controller: _gmailController,
                      validator: gmailValidator,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter your gmail',
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      'Password',
                      style: TextStyle(
                          color: Color(0xFFB91635),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      validator: passwordValidator,
                      keyboardType: TextInputType.number,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminLogin()));
                          },
                          child: Text(
                            'Login as Barber',
                            style: TextStyle(
                                color: Color(0xFF311937),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Color(0xFF311937),
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        log('tapped //  SignIn Button // Login Screen ');

                        if (_formKey2.currentState!.validate()) {
                          userLogin();
                        }
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
                              'Sign In',
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
                            log('tapped //  SignUp Button // Login Screen ');
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Signup()));
                          },
                          child: Text(
                            'Sign up!',
                            style: TextStyle(
                                color: Color(0xFF311937),
                                fontSize: 24,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          'Don\'t have Account?',
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
