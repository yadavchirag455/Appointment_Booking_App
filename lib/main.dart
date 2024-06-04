import 'package:appointment_app/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyA-oLjpnmMo6uahL7Rh3FZjw4wgQXPMJoE',
          appId: '1:352368003187:android:84f6f53dfd63d5b7c24206',
          messagingSenderId: '352368003187',
          projectId: 'barberappointmentapp-b5fc6'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: TextTheme(
              // bodyLarge: TextStyle(color: Colors.white),
              // bodyMedium: TextStyle(color: Colors.white),
              // bodySmall: TextStyle(color: Colors.white),
              ),
          iconTheme: IconThemeData(color: Colors.white)),
      home: LogIn(),
    );
  }
}
