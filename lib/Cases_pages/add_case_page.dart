import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ssip_hackathon_2022/ani_care_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/CasesModel.dart';

String animal = "", doctor = "", disease = "", place = "";
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
                        doctor = value.toString();
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "enter the Doctor Name",
                          label: Text("Doctor"))),
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this Field can't be Empty";
                        }
                        disease = value.toString();
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "enter the disease",
                          label: Text("disease"))),
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "this Field can't be Empty";
                        }
                        place = value.toString();
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "enter the place name",
                          label: Text("Place"))),
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
                              addCase(animal, disease, doctor, DateTime.now(),
                                  place, false);
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

  addCase(String animal, String disease, String doctor, var date, String place,
      bool completed) {
    var _cases = Case_model(
        id: "id",
        animal: animal,
        disease: disease,
        Doctor: doctor,
        date: date,
        place: place,
        completed: completed);
    FirebaseFirestore.instance.collection('new_cases').add(_cases.toJson());
  }

  deletecase(var id) {
    FirebaseFirestore.instance.collection('new_cases').doc(id).delete();
  }
}
