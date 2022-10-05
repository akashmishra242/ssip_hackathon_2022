import 'package:flutter/material.dart';
import 'package:ssip_hackathon_2022/ani_care_page.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/CasesModel.dart';

String animal = "", doctor = "", disease = "", place = "";
final _formkey = GlobalKey<FormState>();

class AddCasePage extends StatelessWidget {
  const AddCasePage({super.key});

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
                              AniCarePage.allcases.add(Case_model(
                                  animal: animal,
                                  disease: disease,
                                  Doctor: doctor,
                                  date: DateTime.now(),
                                  place: place));
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
}
