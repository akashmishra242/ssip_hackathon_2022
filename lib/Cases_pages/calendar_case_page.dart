import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ssip_hackathon_2022/ani_care_page.dart';
import 'package:ssip_hackathon_2022/models/CasesModel.dart';
import 'package:velocity_x/velocity_x.dart';

List<Case_model> calendarcases = [];
DateTime date = DateTime.now();

class CalendarCasePage extends StatefulWidget {
  const CalendarCasePage({super.key});

  @override
  State<CalendarCasePage> createState() => _CalendarCasePageState();
}

class _CalendarCasePageState extends State<CalendarCasePage> {
  @override
  Widget build(BuildContext context) {
    calendarcases.addAll(AniCarePage.allcases);
    calendarcases.retainWhere((element) => element.date.day == date.day);
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  date = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime.utc(2000),
                      lastDate: DateTime.now()) as DateTime;
                  setState(() {});
                },
                icon: Icon(Icons.calendar_today))
          ],
        ),
        body: ListView.builder(
            itemCount: calendarcases.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  calendarcases[index].animal.text.color(Colors.black).make(),
                  calendarcases[index].Doctor.text.color(Colors.black).make(),
                  calendarcases[index].disease.text.color(Colors.black).make(),
                ],
              ).box.color(Colors.lightBlueAccent).roundedSM.make().p4();
            }));
  }
}
