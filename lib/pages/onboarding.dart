import 'dart:developer';
import 'package:flutter/material.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2b1615),
      body: Container(
        margin: EdgeInsets.only(top: 120),
        child: Column(
          children: [
            Image.asset('images/barber.png'),
            SizedBox(height: 80),
            GestureDetector(
              onTap: () {
                log('tapped //  get a hair style button // onboarding screen ');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Color(0xffdf711a),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'Get a hair Style',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
