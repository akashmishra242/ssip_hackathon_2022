import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ssip_hackathon_2022/models/CasesModel.dart';
import 'package:velocity_x/velocity_x.dart';

class AniCarePage extends StatelessWidget {
  const AniCarePage({super.key});
  static List<Case_model> allcases = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
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
        child: Center(
          child: Column(
            children: [
              Column(
                children: [
                  Text("Past Case"),
                  Image.network(
                    "https://cdn1.iconfinder.com/data/icons/calendar-20/200/calendar_23-512.png",
                    width: MediaQuery.of(context).size.width * 0.3,
                  )
                ],
              )
                  .wThreeForth(context)
                  .box
                  .color(Colors.lightGreen)
                  .roundedLg
                  .make()
                  .p4()
                  .onTap(() {
                Navigator.pushNamed(context, "/past_cases");
              }),
              Column(
                children: [
                  Text("Current Case"),
                  Image.network(
                    "https://cdn1.iconfinder.com/data/icons/calendar-20/200/calendar_23-512.png",
                    width: MediaQuery.of(context).size.width * 0.3,
                  )
                ],
              )
                  .wThreeForth(context)
                  .box
                  .color(Colors.lightGreen)
                  .roundedLg
                  .make()
                  .p4()
                  .onTap(() {
                Navigator.pushNamed(context, "/current_cases");
              }),
              Column(
                children: [
                  Text("Add a new Case"),
                  Image.network(
                    "https://cdn1.iconfinder.com/data/icons/calendar-20/200/calendar_23-512.png",
                    width: MediaQuery.of(context).size.width * 0.3,
                  )
                ],
              )
                  .wThreeForth(context)
                  .box
                  .color(Colors.lightGreen)
                  .roundedLg
                  .make()
                  .p4()
                  .onTap(() {
                Navigator.pushNamed(context, "/add_case");
              }),
              Column(
                children: [
                  Text("see cases by calendar"),
                  Image.network(
                    "https://cdn1.iconfinder.com/data/icons/calendar-20/200/calendar_23-512.png",
                    width: MediaQuery.of(context).size.width * 0.3,
                  )
                ],
              )
                  .wThreeForth(context)
                  .box
                  .color(Colors.lightGreen)
                  .roundedLg
                  .make()
                  .p4()
                  .onTap(() {
                Navigator.pushNamed(context, "/calendar_case");
              }),
            ],
          ),
        ),
      ),
    );
  }
}
