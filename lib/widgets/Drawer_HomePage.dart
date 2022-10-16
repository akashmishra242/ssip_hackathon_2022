import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Authentication/UpdateUserData/pick_crop_compress_upload_image.dart';
import '../Authentication/viaEmail/loginPage.dart';

class HomePageDrawer extends StatefulWidget {
  const HomePageDrawer({Key? key}) : super(key: key);

  @override
  State<HomePageDrawer> createState() => _HomePageDrawerState();
}

class _HomePageDrawerState extends State<HomePageDrawer> {
  String fullname = '';

  getUserName() async {
    String name = '';

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    name = "${snapshot['firstName']} ${snapshot['secondName']}";
    log(snapshot.data().toString());
    setState(() {
      fullname = name;
    });
  }

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> logout(BuildContext context) async {
      await FirebaseAuth.instance.signOut();
      if (GoogleSignIn != null) {
        GoogleSignIn().signOut();
      }
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          SizedBox(
            height: 220,
            child: DrawerHeader(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.teal.shade200),
                margin: const EdgeInsets.all(8),
                accountName: Text(
                  FirebaseAuth.instance.currentUser?.displayName ??
                      FirebaseAuth.instance.currentUser?.phoneNumber ??
                      fullname,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                accountEmail: Text(
                  FirebaseAuth.instance.currentUser?.email ?? '',
                ),
                onDetailsPressed: () {},
                otherAccountsPictures: [],
                currentAccountPicture: const UploadImage(),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.profile_circled,
              color: Colors.yellow.shade900,
              size: 35,
            ),
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.bookmark_fill,
              color: Colors.yellow.shade900,
              size: 35,
            ),
            title: const Text(
              "Bookmark",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.settings,
              color: Colors.yellow.shade900,
              size: 35,
            ),
            title: const Text(
              "Setting",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.globe,
              color: Colors.yellow.shade900,
              size: 35,
            ),
            title: const Text(
              "Language",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.question_circle_fill,
              color: Colors.yellow.shade900,
              size: 35,
            ),
            title: const Text(
              "Help & Support",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          ActionChip(
              elevation: 5,
              labelStyle:
                  const TextStyle(fontSize: 25, fontWeight: FontWeight.normal),
              backgroundColor: Colors.red.shade100,
              label: const Text("Logout"),
              avatar: const Icon(
                Icons.logout,
                size: 25,
              ),
              onPressed: () async {
                logout(context);
              }),
        ],
      ),
    );
  }
}
