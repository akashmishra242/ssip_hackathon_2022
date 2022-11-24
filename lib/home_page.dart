import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ssip_hackathon_2022/ani_care_page.dart';
import 'widgets/Calender/sfcalender.dart';
import 'widgets/Drawer/Drawer_HomePage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var UserName;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Home Page",
          style: TextStyle(color: Colors.black),
        )),
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      drawer: const HomePageDrawer(),
      body: Column(
        children: [
          Center(child: Text("this is body.")),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 8),
            child: SizedBox(
                height: 30,
                child: Text(
                  "welcome ${FirebaseAuth.instance.currentUser!.email == null ? FirebaseAuth.instance.currentUser!.phoneNumber : FirebaseAuth.instance.currentUser!.email ?? ''} :(",
                  textScaleFactor: 1.5,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )),
          ),
          const SizedBox(
              height: 25,
              child: Text(
                  "<<<-----Just for navigation(you can remove later)--->>>")),
          ActionChip(
              elevation: 5,
              labelStyle:
                  const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
              backgroundColor: Colors.red.shade100,
              label: const Text("antiCarePage"),
              avatar: const Icon(
                Icons.logout,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AniCarePage()));
              }),
          ActionChip(
              elevation: 5,
              labelStyle:
                  const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
              backgroundColor: Colors.red.shade100,
              label: const Text("SFCalenderPage"),
              avatar: const Icon(
                Icons.logout,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SyncfusionCalender()));
              }),
        ],
      ),
    );
  }
}
