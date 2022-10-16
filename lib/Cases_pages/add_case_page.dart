import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ssip_hackathon_2022/ani_care_page.dart';
import 'package:ssip_hackathon_2022/home_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/CasesModel.dart';

String animal = "",
    doctor = "",
    disease = "",
    place = "",
    date = "",
    month = "",
    year = "",
    state = "",
    disease_desc = "",
    owner_name = "",
    owner_mobile_no = "",
    breed = "";
final _formkey = GlobalKey<FormState>();

class AddCasePage extends StatefulWidget {
  const AddCasePage({super.key});

  @override
  State<AddCasePage> createState() => _AddCasePageState();
}

class _AddCasePageState extends State<AddCasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this Field can't be Empty";
                        }
                        animal = value.toString();
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Specify the Animal",
                          label: Text("Animal"))),
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this Field can't be Empty";
                        }
                        breed = value.toString();
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "enter the Doctor Name",
                          label: Text("breed"))),
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this Field can't be Empty";
                        }
                        disease = value.toString();
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "enter the Doctor Name",
                          label: Text("disease"))),
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this Field can't be Empty";
                        }
                        doctor = value.toString();
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "enter the disease",
                          label: Text("doctor"))),
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this Field can't be Empty";
                        }
                        place = value.toString();
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "enter the Doctor Name",
                          label: Text("City"))),
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this Field can't be Empty";
                        }
                        state = value.toString();
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "enter the Doctor Name",
                          label: Text("State"))),
                  ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              // AniCarePage.allcases.add(Case_model(
                              //   id:"id",
                              //     animal: animal,
                              //     disease: disease,
                              //     Doctor: doctor,
                              //     date: DateTime.now(),
                              //     place: place,
                              //     completed: false));
                              addCase(
                                  animal,
                                  disease,
                                  doctor,
                                  DateTime.now().day.toString(),
                                  place,
                                  false,
                                  DateTime.now().month.toString(),
                                  DateTime.now().year.toString(),
                                  state,
                                  breed);
                              Navigator.of(context).pop();
                            }
                          },
                          child: Text("add"))
                      .p20()
                ],
              )).px12().py64(),
        ),
      ),
    );
  }

  addCase(
      String animal,
      String disease,
      String doctor,
      String date,
      String place,
      bool completed,
      String month,
      String year,
      String state,
      String breed) {
    var _cases = Case_model(
        id: "${AniCarePage.allcases.length + 1}",
        animal: animal,
        disease: disease,
        Doctor: doctor,
        date: date,
        month: month,
        year: year,
        state: state,
        breed: breed,
        completed: completed,
        place: place,
        diseaseDesc: disease_desc,
        ownerMobileNo: owner_mobile_no,
        ownerName: owner_name);
    FirebaseFirestore.instance.collection('new_cases').add(_cases.toJson());
  }

  deletecase(var id) {
    FirebaseFirestore.instance.collection('new_cases').doc(id).delete();
  }
}
