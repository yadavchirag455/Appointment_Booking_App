import 'dart:developer';
import 'package:appointment_app/admin/admin_booking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  loginAdmin() async {
    await FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        log(result.data()['id']);

        log("${_userNameTextController.text.trim()}");

        log(result.data()['password']);

        log("${_passwordTextController.text.trim()}");

        if (result.data()['id'] != _userNameTextController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            'Your Id is not Correct',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )));
        } else if (result.data()['password'] !=
            _passwordTextController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
            'Your password is not Correct',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AdminBooking()));
        }
      });
    });
  }

  final _userNameTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

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
                'Hello \nAdmin! Please Login!',
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
                // key: _formKey2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Username',
                      style: TextStyle(
                          color: Color(0xFFB91635),
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                    TextFormField(
                      controller: _userNameTextController,
                      // controller: _gmailController,
                      // validator: gmailValidator,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Enter Username',
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
                      controller: _passwordTextController,
                      // controller: _passwordController,
                      // validator: passwordValidator,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.black45,
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height: 50),
                    GestureDetector(
                      onTap: () {
                        log('tapped // login Button // Admin Login Screen ');

                        loginAdmin();
                        //
                        // if (_formKey2.currentState!.validate()) {
                        //   userLogin();
                        // }
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
                              'Log in!!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Spacer(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     GestureDetector(
                    //       onTap: () {
                    //         // log('tapped //  SignUp Button // Login Screen ');
                    //         // Navigator.pushReplacement(
                    //         //     context,
                    //         //     MaterialPageRoute(
                    //         //         builder: (context) => Signup()));
                    //       },
                    //       child: Text(
                    //         'Sign up!',
                    //         style: TextStyle(
                    //             color: Color(0xFF311937),
                    //             fontSize: 24,
                    //             fontWeight: FontWeight.w600),
                    //       ),
                    //     ),
                    //     Text(
                    //       'Don\'t have Account?',
                    //       style: TextStyle(
                    //           color: Color(0xFF311937),
                    //           fontSize: 16,
                    //           fontWeight: FontWeight.w600),
                    //     ),
                    //   ],
                    // ),
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
