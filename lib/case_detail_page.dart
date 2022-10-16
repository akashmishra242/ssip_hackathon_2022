import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ssip_hackathon_2022/models/CasesModel.dart';
import 'package:velocity_x/velocity_x.dart';

class CaseDetailPage extends StatelessWidget {
  const CaseDetailPage({super.key});
  static Case_model selectedcase = Case_model(
      id: "",
      animal: "",
      disease: "",
      Doctor: "",
      date: "",
      month: "",
      year: "",
      state: "",
      breed: "",
      completed: false,
      place: "");
  @override
  Widget build(BuildContext context) {
    String completed = selectedcase.completed ? "Completed" : "Not Completed";
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            "animal".text.make().p4(),
            "disease".text.make().p4(),
            "Doctor".text.make().p4(),
            "date".text.make().p4(),
            "state".text.make().p4(),
            "place".text.make().p4(),
            "breed".text.make().p4(),
            "completed".text.make().p4(),
            "diseaseDesc".text.make().p4(),
            "ownerName".text.make().p4(),
            "ownerMobileNo".text.make().p4(),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ":".text.make().p4(),
              ":".text.make().p4(),
              ":".text.make().p4(),
              ":".text.make().p4(),
              ":".text.make().p4(),
              ":".text.make().p4(),
              ":".text.make().p4(),
              ":".text.make().p4(),
              ":".text.make().p4(),
              ":".text.make().p4(),
              ":".text.make().p4(),
            ],
          ),
          Column(
            children: [
              selectedcase.animal.text.make().p4(),
              selectedcase.disease.text.make().p4(),
              selectedcase.Doctor.text.make().p4(),
              "${selectedcase.date}/${selectedcase.month}/${selectedcase.year}"
                  .text
                  .make()
                  .p4(),
              selectedcase.state.text.make().p4(),
              selectedcase.place.text.make().p4(),
              selectedcase.breed.text.make().p4(),
              completed.text.make().p4(),
              selectedcase.diseaseDesc.toString().text.make().p4(),
              selectedcase.ownerName.toString().text.make().p4(),
              selectedcase.ownerMobileNo.toString().text.make().p4(),
            ],
          )
        ],
      ),
    );
  }
}
