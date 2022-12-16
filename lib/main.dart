import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ssip_hackathon_2022/Authentication/MyRoutes.dart';
import 'package:ssip_hackathon_2022/Cases_pages/add_case_page.dart';
import 'package:ssip_hackathon_2022/Cases_pages/past_cases.dart';
import 'package:ssip_hackathon_2022/Cases_pages/current_cases.dart';
import 'package:ssip_hackathon_2022/ani_care_page.dart';
import 'package:ssip_hackathon_2022/case_detail_page.dart';
import 'package:ssip_hackathon_2022/firebase_options.dart';

import 'Authentication/viaEmail/SignupPage.dart';
import 'Authentication/viaEmail/loginPage.dart';
import 'home_page.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';

void main() async {
  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSIP HACKATHON 2022',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AniCarePage(),
      initialRoute: '/login',
      debugShowCheckedModeBanner: false,
      routes: {
        MyRoutes.HomePage: (context) => const MyHomePage(),
        MyRoutes.LoginPage: (context) => const LoginScreen(),
        MyRoutes.SignUpPage: (context) => const RegistrationState(),
        MyRoutes.AnimalCarePage: (context) => const AniCarePage(),
        MyRoutes.PastCasesPage: (context) => const PastCasesPage(),
        MyRoutes.CurrentCasesPage: (context) => const CurrentCasesPage(),
        MyRoutes.AddCasePage: (context) => const AddCasePage(),
        MyRoutes.CaseDetailPage: (context) => const CaseDetailPage(),
      },
    );
  }
}
