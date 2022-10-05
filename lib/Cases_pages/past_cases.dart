import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ssip_hackathon_2022/ani_care_page.dart';
import 'package:ssip_hackathon_2022/models/CasesModel.dart';
import 'package:velocity_x/velocity_x.dart';

List<Case_model> pastcases = [];

class PastCasesPage extends StatelessWidget {
  const PastCasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    pastcases = [];
    pastcases.addAll(AniCarePage.allcases);
    pastcases.retainWhere((element) => element.completed);
    return Scaffold(
        appBar: AppBar(
          title: Text("Past Cases"),
        ),
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
                      pastcases[index].disease.text.color(Colors.black).make(),
                    ],
                  ).p16(),
                  Icon(Icons.done_outline).p12(),
                ],
              ).box.color(Colors.lightBlueAccent).roundedSM.make().p4();
            }));
  }
}
