import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ssip_hackathon_2022/Cases_pages/add_case_page.dart';
import 'package:ssip_hackathon_2022/ani_care_page.dart';
import 'package:ssip_hackathon_2022/models/CasesModel.dart';
import 'package:velocity_x/velocity_x.dart';

class CurrentCasesPage extends StatefulWidget {
  const CurrentCasesPage({super.key});
  @override
  State<CurrentCasesPage> createState() => _CurrentCasesPageState();
}

List<Case_model> currentcases = [];

class _CurrentCasesPageState extends State<CurrentCasesPage> {
  List<String> collectionpath = ['new_cases'];
  var isloaded = false;
  @override
  void initState() {
    fetchdata();
    FirebaseFirestore.instance
        .collection('new_cases')
        .snapshots()
        .listen((record) {
      mapRecords(record);
    });
    super.initState();
  }

  fetchdata() async {
    var records = await FirebaseFirestore.instance
        .collection('new_cases')
        .where("completed", isEqualTo: false)
        .get();
    log(records.docs.toString());
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _recv = records.docs
        .map(
          (element) => Case_model(
              animal: element["animal"],
              disease: element["disease"],
              Doctor: element["Doctor"],
              date: DateTime.now(),
              place: element["place"],
              completed: false),
        )
        .toList();
    setState(() {
      currentcases = _recv;
      //currentcases.retainWhere((element) => !element.completed);
      if (records.docs.length != null) {
        isloaded = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //currentcases = [];
    //currentcases.addAll(AniCarePage.allcases);
    //currentcases.retainWhere((element) => element.completed == false);
    return Scaffold(
        appBar: AppBar(
          title: Text("Current Cases"),
        ),
        body: Visibility(
          visible: isloaded,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.builder(
              itemCount: currentcases.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        currentcases[index]
                            .animal
                            .text
                            .color(Colors.black)
                            .make(),
                        currentcases[index]
                            .Doctor
                            .text
                            .color(Colors.black)
                            .make(),
                        currentcases[index]
                            .disease
                            .text
                            .color(Colors.black)
                            .make(),
                      ],
                    ).p16(),
                    IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: Text("Are you Sure"),
                                      content: Text(
                                          "are You Sure that this case has been Completed !!"),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              currentcases[index].completed =
                                                  true;

                                              // updated on firebase as well
                                              FirebaseFirestore.instance
                                                  .collection('new_cases')
                                                  .doc()
                                                  .update({'completed': true});
                                              Navigator.of(context).pop();
                                              setState(() {});
                                            },
                                            child: Text("Yes")),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("No"))
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(Icons.done))
                        .p16(),
                    currentcases[index].animal.text.color(Colors.black).make(),
                    currentcases[index].Doctor.text.color(Colors.black).make(),
                    currentcases[index].disease.text.color(Colors.black).make(),
                  ],
                ).box.color(Colors.lightBlueAccent).roundedSM.make().p4();
              }),
        ));
  }
}
