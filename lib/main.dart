import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ssip_hackathon_2022/Cases_pages/add_case_page.dart';
import 'package:ssip_hackathon_2022/Cases_pages/past_cases.dart';
import 'package:ssip_hackathon_2022/Cases_pages/current_cases.dart';
import 'package:ssip_hackathon_2022/ani_care_page.dart';
import 'package:ssip_hackathon_2022/firebase_options.dart';

import 'Authentication/viaEmail/SignupPage.dart';
import 'Authentication/viaEmail/loginPage.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AniCarePage(),
      initialRoute: "/anti_care",
      routes: {
        "/home": (context) => const MyHomePage(),
        "/login": (context) => const LoginScreen(),
        "/signup": (context) => const RegistrationState(),
        "/anti_care": (context) => const AniCarePage(),
        "/past_cases": (context) => const PastCasesPage(),
        "/current_cases": (context) => const CurrentCasesPage(),
        "/add_case": (context) => const AddCasePage(),
      },
    );
  }
}
