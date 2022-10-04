import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ssip_hackathon_2022/ani_care_page.dart';
import 'package:ssip_hackathon_2022/models/CasesModel.dart';
import 'package:velocity_x/velocity_x.dart';

List<Case_model> currentcases = [];

class CurrentCasesPage extends StatelessWidget {
  const CurrentCasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    currentcases.addAll(AniCarePage.allcases);
    currentcases.retainWhere((element) => element.completed);
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            itemCount: currentcases.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  currentcases[index].animal.text.color(Colors.black).make(),
                  currentcases[index].Doctor.text.color(Colors.black).make(),
                  currentcases[index].desies.text.color(Colors.black).make(),
                ],
              ).box.color(Colors.lightBlueAccent).roundedSM.make().p4();
            }));
  }
}
