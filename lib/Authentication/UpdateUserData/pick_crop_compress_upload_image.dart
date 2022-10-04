import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  String imageurl = '';
  String recvimg = '';

  ///function to openbottom modal sheet on clicking image
  Future selectPhoto() async {
    await showModalBottomSheet(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.width * 0.45),
      elevation: 15,
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.15,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  border: Border.all(
                    color: Colors.black,
                  )),
              child: const Text(
                "Select Image",
                style: TextStyle(color: Colors.black),
                textScaleFactor: 2.5,
              ),
            ),
            ListTile(
              iconColor: Colors.amber.shade900,
              selectedColor: Colors.blue.shade100,
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            Divider(
              height: 5,
              color: Colors.black,
              endIndent: MediaQuery.of(context).size.width * 0.025,
              indent: MediaQuery.of(context).size.width * 0.025,
              thickness: 2,
            ),
            ListTile(
              iconColor: Colors.amber.shade900,
              selectedColor: Colors.blue.shade100,
              leading: const Icon(Icons.filter),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  ///function to uploadfile to firebase storage////
  Future uploadfile(String path) async {
    UploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child("profilepictures")
        .child('${DateTime.now().toIso8601String()}.${p.basename(path)}')
        .putFile(File(path));

    StreamSubscription taskSubscription =
        uploadTask.snapshotEvents.listen((snapshot) {
      double percentage = snapshot.bytesTransferred / snapshot.totalBytes * 100;
      log(percentage.toString());
    });
    TaskSnapshot tasksnapshot = await uploadTask;
    String urlFromFirebaseCloud = await tasksnapshot.ref.getDownloadURL();

    Map<String, dynamic> userimage = {
      'imageurl': urlFromFirebaseCloud,
      'id': FirebaseAuth.instance.currentUser?.uid,
    };
    if (urlFromFirebaseCloud != '') {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('userselectedimage')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      if (snapshot.data() == null) {
        log("no data found to setting the profile pic to firestore for first time");
        FirebaseFirestore.instance
            .collection('userselectedimage')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .set(userimage);
      } else {
        log("updating the current profile pic");
        FirebaseFirestore.instance
            .collection('userselectedimage')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .update({'imageurl': urlFromFirebaseCloud});
      }
    }

    setState(() {
      imageurl = urlFromFirebaseCloud;
      log(urlFromFirebaseCloud);
    });
    taskSubscription.cancel();
  }

  @override
  //this is how we receive data from firestore,
  //wehave to initialize it first and have to listen to it also,
  //we haveto make a function to recieve the data;
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('userselectedimage')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .listen((event) {
      recvimage(event);
    });
  }

  recvimage(DocumentSnapshot<Map<String, dynamic>> event) {
    var _recvimg = event.get('imageurl').toString();
    setState(() {
      recvimg = _recvimg;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: GestureDetector(
        onLongPress: () async {
          log("Long pressed");
          await selectPhoto();
        },
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Container(
                  padding: const EdgeInsets.only(top: 24, left: 8, right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            CupertinoIcons.return_icon,
                            color: Colors.black,
                            size: 50,
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Image.network(recvimg == ''
                          ? FirebaseAuth.instance.currentUser!.photoURL ??
                              'https://cdn3.vectorstock.com/i/1000x1000/66/37/person-icon-male-add-user-profile-avatar-plus-vector-21206637.jpg'
                          : recvimg),
                    ],
                  ));
            },
          );
        },
        child: recvimg == ''
            ? CircleAvatar(
                backgroundImage: NetworkImage(
                  FirebaseAuth.instance.currentUser?.photoURL ??
                      'https://cdn3.vectorstock.com/i/1000x1000/66/37/person-icon-male-add-user-profile-avatar-plus-vector-21206637.jpg',
                  scale: 5,
                ),
                radius: 35,
              )
            : CircleAvatar(
                backgroundImage: NetworkImage(
                  recvimg,
                  scale: 5,
                ),
                radius: 35,
              ),
      ),
    );
  }

//function to pick,crop,compress image
  _pickImage(ImageSource source) async {
    //file picking from galery or camera
    XFile? pickedfile = await ImagePicker().pickImage(source: source);
    if (pickedfile == null) {
      return;
    } else {
      File finalpickedfile = File(pickedfile.path); //making output to file

      // cropping the pickedfile
      CroppedFile? croppedfile = await ImageCropper().cropImage(
          sourcePath: finalpickedfile.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));

      File finalcroppedfile = File(croppedfile!.path); //making output to file

      //// //calling funtion to compressfile
      File? finalfile = await compressfile(finalcroppedfile.path);

      ///caling function to upload file to storage
      await uploadfile(finalfile!.path);
    }
  }

////function to compressfile////
  Future<File?> compressfile(String path) async {
//setting the new path of file
    final targetpath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');
    //compressing the cropped file at new path.
    File? finalfile = await FlutterImageCompress.compressAndGetFile(
        path, targetpath,
        quality: 50);
    log("file compressed");
    return finalfile; //returning the final image as file.
  }
}
