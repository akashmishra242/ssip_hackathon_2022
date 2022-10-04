import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ssip_hackathon_2022/ani_care_page.dart';
import 'package:ssip_hackathon_2022/models/CasesModel.dart';
import 'package:velocity_x/velocity_x.dart';

class PastCasesPage extends StatefulWidget {
  const PastCasesPage({super.key});

  @override
  State<PastCasesPage> createState() => _PastCasesPageState();
}

class _PastCasesPageState extends State<PastCasesPage> {
  @override
  Widget build(BuildContext context) {
    List<Case_model> pastcases = [];
    pastcases.addAll(AniCarePage.allcases);
    pastcases.retainWhere((element) => element.completed == false);
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            itemCount: pastcases.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      pastcases[index].animal.text.color(Colors.black).make(),
                      pastcases[index].Doctor.text.color(Colors.black).make(),
                      pastcases[index].desies.text.color(Colors.black).make(),
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
                                            pastcases[index].completed = true;
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
                      .p16()
                ],
              ).box.color(Colors.lightBlueAccent).roundedSM.make().p4();
            }));
  }
}
