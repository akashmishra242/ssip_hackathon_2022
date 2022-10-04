import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ssip_hackathon_2022/firebase_options.dart';

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
      home: const MyHomePage(),
      initialRoute: "login",
      routes: {
        "home": (context) => const MyHomePage(),
        "login": (context) => const LoginScreen(),
      },
    );
  }
}
