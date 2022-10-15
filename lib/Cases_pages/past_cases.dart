import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ssip_hackathon_2022/ani_care_page.dart';
import 'package:ssip_hackathon_2022/models/CasesModel.dart';
import 'package:velocity_x/velocity_x.dart';

List<Case_model> pastcases = [];

class PastCasesPage extends StatefulWidget {
  const PastCasesPage({super.key});

  @override
  State<PastCasesPage> createState() => _PastCasesPageState();
}

class _PastCasesPageState extends State<PastCasesPage> {
  @override
  Widget build(BuildContext context) {
    pastcases = [];
    pastcases.addAll(AniCarePage.allcases);
    pastcases.retainWhere((element) => element.completed);
    return Scaffold(
        appBar: AppBar(
          title: Text("Past Cases"),
          backgroundColor: Color.fromARGB(255, 74, 188, 150),
        ),
        body: ListView.builder(
            itemCount: pastcases.length,
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
                              pastcases[index]
                                  .animal
                                  .text
                                  .color(Colors.black)
                                  .make(),
                              pastcases[index]
                                  .Doctor
                                  .text
                                  .color(Colors.black)
                                  .make(),
                              pastcases[index]
                                  .disease
                                  .text
                                  .color(Colors.black)
                                  .make(),
                            ],
                          ).p16(),
                          Icon(Icons.done_outline).p20(),
                        ],
                      )
                          .box
                          .color(Color.fromARGB(213, 239, 249, 238))
                          .roundedSM
                          .make())
                  .px8()
                  .py4();
            }));
  }
}
