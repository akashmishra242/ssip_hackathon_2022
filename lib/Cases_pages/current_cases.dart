import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                                            setCase(
                                                currentcases[index].id ?? '',
                                                currentcases[index].animal,
                                                currentcases[index].disease,
                                                currentcases[index].Doctor,
                                                currentcases[index].date,
                                                currentcases[index].place,
                                                true);
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

  setCase(String id, String animal, String disease, String doctor,
      DateTime date, String place, bool completed) {
    var _cases = Case_model(
        id: id,
        animal: animal,
        disease: disease,
        Doctor: doctor,
        date: date.toUtc(),
        place: place,
        completed: completed);
    FirebaseFirestore.instance
        .collection('new_cases')
        .doc(id)
        .set(_cases.toJson());
  }

  deletecase(var id) {
    FirebaseFirestore.instance.collection('new_cases').doc(id).delete();
  }
}
