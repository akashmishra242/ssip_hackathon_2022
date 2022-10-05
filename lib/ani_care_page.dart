import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ssip_hackathon_2022/models/CasesModel.dart';
import 'package:velocity_x/velocity_x.dart';

int curr_index = 0;

class AniCarePage extends StatefulWidget {
  const AniCarePage({super.key});
  static List<Case_model> allcases = [];

  @override
  State<AniCarePage> createState() => _AniCarePageState();
}

List<Case_model> calendarcases = [];
DateTime date = DateTime.now();

class _AniCarePageState extends State<AniCarePage> {
  List<String> collectionpath = ['new_cases'];
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
    var records =
        await FirebaseFirestore.instance.collection('new_cases').get();
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
      AniCarePage.allcases = _recv;
    });
  }

  @override
  Widget build(BuildContext context) {
    calendarcases = [];
    calendarcases.addAll(AniCarePage.allcases);
    calendarcases.retainWhere((element) => element.date.day == date.day);
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
          ),
          Image.asset(
            "Assets/Images/appbar.png",
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.15,
          )
        ],
        centerTitle: true,
        title: Text(
          "AniCare",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: curr_index == 2
            ? Column(
                children: [
                  IconButton(
                      onPressed: () async {
                        var data = await showDatePicker(
                            context: context,
                            initialDate: date,
                            firstDate: DateTime.utc(2000),
                            lastDate: DateTime.now());
                        if (data != null) date = data as DateTime;
                        setState(() {});
                      },
                      icon: Icon(Icons.calendar_today)),
                  calendarcases.length > 0
                      ? ListView.builder(
                          itemCount: calendarcases.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    calendarcases[index]
                                        .animal
                                        .text
                                        .color(Colors.black)
                                        .make(),
                                    calendarcases[index]
                                        .Doctor
                                        .text
                                        .color(Colors.black)
                                        .make(),
                                    calendarcases[index]
                                        .disease
                                        .text
                                        .color(Colors.black)
                                        .make(),
                                  ],
                                ).p16(),
                                Text("${date.day}/${date.month}/${date.year}")
                                    .p16()
                              ],
                            )
                                .box
                                .color(Colors.lightBlueAccent)
                                .roundedSM
                                .make()
                                .p4();
                          }).expand()
                      : Center(child: Text("No Cases on selected Date"))
                ],
              ).hThreeForth(context)
            : curr_index == 1
                ? Container()
                : curr_index == 3
                    ? Center(
                        child: Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {}, child: Text("Log Out")),
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              "Past Case".text.scale(2).bold.make(),
                              Image.asset(
                                "Assets/Images/done.jpg",
                                width: MediaQuery.of(context).size.width * 0.3,
                              ).p12()
                            ],
                          )
                              .p8()
                              .wThreeForth(context)
                              .box
                              .color(Colors.lightGreen)
                              .roundedLg
                              .make()
                              .p4()
                              .onTap(() {
                            Navigator.pushNamed(context, "/past_cases");
                          }).p4(),
                          Column(
                            children: [
                              "Current Case".text.scale(2).bold.make(),
                              Image.asset(
                                "Assets/Images/suitcase.jpeg",
                                width: MediaQuery.of(context).size.width * 0.25,
                              ).p12()
                            ],
                          )
                              .p8()
                              .wThreeForth(context)
                              .box
                              .color(Colors.lightGreen)
                              .roundedLg
                              .make()
                              .p4()
                              .onTap(() {
                            Navigator.pushNamed(context, "/current_cases");
                          }).p4(),
                          Column(
                            children: [
                              "Add a new Case".text.scale(2).bold.make(),
                              Image.asset(
                                "Assets/Images/add cases.jpeg",
                                width: MediaQuery.of(context).size.width * 0.2,
                              ).p12()
                            ],
                          )
                              .p8()
                              .wThreeForth(context)
                              .box
                              .color(Colors.lightGreen)
                              .roundedLg
                              .make()
                              .p4()
                              .onTap(() {
                            Navigator.pushNamed(context, "/add_case");
                          }).p4(),
                        ],
                      ).hThreeForth(context)),
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.green,
          selectedItemColor: Colors.lightBlue,
          currentIndex: curr_index,
          onTap: (value) {
            curr_index = value;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on), label: "Location"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month), label: "Calendar"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded), label: "Account")
          ]),
    );
  }
}
