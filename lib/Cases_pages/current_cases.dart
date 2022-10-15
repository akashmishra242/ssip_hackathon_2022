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
          backgroundColor: Color.fromARGB(255, 74, 188, 150),
        ),
        body: ListView.builder(
            itemCount: currentcases.length,
            itemBuilder: (context, index) {
              return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      clipBehavior: Clip.antiAlias,
                      elevation: 10.0,
                      child: Row(
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
                          ),
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
                                                    FirebaseFirestore.instance
                                                        .collection('new_cases')
                                                        .doc(currentcases[index]
                                                            .id)
                                                        .update({
                                                      'completed': true
                                                    });
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
                      )
                          .p12()
                          .box
                          .color(const Color.fromARGB(213, 239, 249, 238))
                          .roundedSM
                          .make())
                  .px8()
                  .py4();
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
