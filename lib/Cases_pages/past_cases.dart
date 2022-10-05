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
  List<String> collectionpath = ['new_cases'];
  var isloaded = false;
  @override
  void initState() {
    fetchdata();
    FirebaseFirestore.instance
        .collection('new_cases')
        .snapshots()
        .listen((record) {
      mapRecords(record);
    });
    super.initState();
  }

  fetchdata() async {
    var records = await FirebaseFirestore.instance
        .collection('new_cases')
        .where("completed", isNotEqualTo: false)
        .get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _recv = records.docs
        .map(
          (element) => Case_model(
              animal: element["animal"],
              disease: element["disease"],
              Doctor: element["Doctor"],
              date: DateTime.now(),
              place: element["place"],
              completed: false),
        )
        .toList();

    setState(() {
      pastcases = _recv;
    });
    if (records.docs.length != null) {
      isloaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // pastcases = [];
    // pastcases.addAll(AniCarePage.allcases);
    // pastcases.retainWhere((element) => element.completed);
    return Scaffold(
        appBar: AppBar(
          title: Text("Past Cases"),
        ),
        body: Visibility(
          visible: isloaded,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.builder(
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
                        pastcases[index]
                            .disease
                            .text
                            .color(Colors.black)
                            .make(),
                      ],
                    ).p16(),
                    Icon(Icons.done_outline).p12(),
                  ],
                ).box.color(Colors.lightBlueAccent).roundedSM.make().p4();
              }),
        ));
  }
}
