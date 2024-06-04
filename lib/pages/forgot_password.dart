import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
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

  resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Email Send to Your Email')));
    } on FirebaseAuthException catch (e) {
      print(e.code.toString());
      log(e.code.toString());
    }
  }

  final _formKey3 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Form(
          key: _formKey3,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: 70,
              // ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Password Recover Here',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),

              Text(
                'Enter Your Email',
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),

              // TextFormField(
              //   validator: gmailValidator,
              //   controller: _emailController,
              //   decoration: InputDecoration(
              //       hintText: 'Enter Your Email',
              //       hintStyle: TextStyle(color: Colors.white70),
              //       prefixIcon: Icon(
              //         Icons.email_outlined,
              //         color: Colors.white70,
              //       )),
              // )

              TextFormField(
                validator: gmailValidator,
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Enter Your Email',
                  hintStyle: TextStyle(color: Colors.white70),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.white70,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Set your desired radius here
                    borderSide: BorderSide(
                        color: Colors.white70), // Customize border color
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Same radius for focused state
                    borderSide: BorderSide(
                        color: Colors.blue), // Change color on focus (optional)
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Same radius for error state
                    borderSide: BorderSide(
                        color: Colors.red), // Change color on error (optional)
                  ),
                ),
              ),

              SizedBox(
                height: 40,
              ),
              TextButton(
                  onPressed: () async {
                    log('Tapped // Done TextButton // on the Forgot Password Screen Page');

                    if (_formKey3.currentState!.validate()) {
                      resetPassword();
                    }
                  },
                  child: Text(
                    "Send Email",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
