import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
<<<<<<< HEAD
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
                          .desies
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
=======
                  currentcases[index].animal.text.color(Colors.black).make(),
                  currentcases[index].Doctor.text.color(Colors.black).make(),
                  currentcases[index].disease.text.color(Colors.black).make(),
>>>>>>> 097849f738bcc1658ae20f0932fa30d3533e7187
                ],
              ).box.color(Colors.lightBlueAccent).roundedSM.make().p4();
            }));
  }
}
