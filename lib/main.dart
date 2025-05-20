import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterr2/Homepage.dart';
import 'package:flutterr2/Splashscreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BioHealthAPP());
}

class BioHealthAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BioHealth",
      theme: ThemeData(
        primaryColor: Colors.green[300],
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Arial',
      ),
      home:Splashscreen(),


    );
  }
}