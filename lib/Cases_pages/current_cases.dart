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
  @override
  Widget build(BuildContext context) {
    currentcases = [];
    currentcases.addAll(AniCarePage.allcases);
    currentcases.retainWhere((element) => element.completed == false);
    return Scaffold(
        appBar: AppBar(
          title: Text("Current Cases"),
        ),
        body: ListView.builder(
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
                                    title: const Text("Are you Sure"),
                                    content: const Text(
                                        "are You Sure that this case has been Completed !!"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            AniCarePage.allcases[index]
                                                .completed = true;
                                            Navigator.of(context).pop();

                                            setState(() {});
                                          },
                                          child: const Text("Yes")),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("No"))
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(Icons.done))
                      .p16(),
                ],
              ).box.color(Colors.lightBlueAccent).roundedSM.make().p4();
            }));
  }

  addCase(String animal, String disease, String doctor, var date, String place,
      bool completed) {
    var _cases = Case_model(
        animal: animal,
        disease: disease,
        Doctor: doctor,
        date: date,
        place: place,
        completed: completed);
    FirebaseFirestore.instance.collection('new_cases').add(_cases.toJson());
  }
}
