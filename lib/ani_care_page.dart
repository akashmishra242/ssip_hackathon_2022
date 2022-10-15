import 'dart:async';
import 'package:ssip_hackathon_2022/Authentication/viaEmail/loginPage.dart';

import 'locations.dart' as locations;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ssip_hackathon_2022/models/CasesModel.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
            id: element.id,
            animal: element["animal"],
            disease: element["disease"],
            Doctor: element["Doctor"],
            date: element["date"],
            place: element["place"],
            completed: element["completed"],
            breed: element["breed"],
            month: element["month"],
            state: element["state"],
            year: element["year"],
            diseaseDesc: element["diseaseDesc"],
            ownerMobileNo: element["ownerMobileNo"],
            ownerName: element["ownerName"],
          ),
        )
        .toList();
    setState(() {
      AniCarePage.allcases = _recv;
    });
  }

  @override
  Widget build(BuildContext context) {
    late GoogleMapController mapController;

    final LatLng _center = const LatLng(45.521563, -122.677433);

    void _onMapCreated(GoogleMapController controller) {
      mapController = controller;
    }

    calendarcases = [];
    calendarcases.addAll(AniCarePage.allcases);
    //calendarcases.retainWhere((element) => element.date.day == date.day);
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: const [
          UserAccountsDrawerHeader(
            accountName: Text("Animal Care App"),
            accountEmail: Text("animalcare.gmail.com"),
            currentAccountPicture: CircleAvatar(),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text("About Us"),
          ),
          ListTile(
            leading: Icon(Icons.call),
            title: Text("Customer Support"),
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text("Rate Our App"),
          )
        ],
      )),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "AniCare",
          style:
              TextStyle(color: Color.fromARGB(187, 74, 188, 150), fontSize: 40),
        ),
        actions: [
          Image.asset(
            "Assets/Images/appbar.png",
          ).px32(),
        ],
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
                      icon: const Icon(Icons.calendar_today)),
                  calendarcases.isNotEmpty
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
                      : const Center(child: Text("No Cases on selected Date"))
                ],
              ).h60(context)
            : curr_index == 1
                ? Center(
                    child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                  )).h60(context)
                : curr_index == 3
                    ? Center(
                        child: Column(
                          children: [
                            ElevatedButton(
                                onPressed: () {}, child: const Text("Log Out")),
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                              elevation: 15.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                children: [
                                  "Past Case".text.scale(2).bold.make(),
                                  Image.asset(
                                    "Assets/Images/done.png",
                                  ).p12()
                                ],
                              )
                                  .p8()
                                  .wThreeForth(context)
                                  .box
                                  .color(Color.fromARGB(213, 239, 249, 238))
                                  .roundedLg
                                  .make()
                                  .onTap(() {
                                Navigator.pushNamed(context, "/past_cases");
                              })).p12(),
                          Card(
                            elevation: 15.0,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              children: [
                                "Current Case".text.scale(2).bold.make(),
                                Image.asset(
                                  "Assets/Images/suitcase.png",
                                ).p12()
                              ],
                            )
                                .p8()
                                .wThreeForth(context)
                                .box
                                .color(Color.fromARGB(213, 239, 249, 238))
                                .roundedLg
                                .make()
                                .onTap(() {
                              Navigator.pushNamed(context, "/current_cases");
                            }),
                          ).p12(),
                          Card(
                            elevation: 15.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              children: [
                                "Add a new Case".text.scale(2).bold.make(),
                                Image.asset(
                                  "Assets/Images/add cases.png",
                                ).p12()
                              ],
                            )
                                .p8()
                                .wThreeForth(context)
                                .box
                                .color(const Color.fromARGB(213, 239, 249, 238))
                                .roundedLg
                                .make()
                                .onTap(() {
                              Navigator.pushNamed(context, "/add_case");
                            }),
                          ).p12(),
                        ],
                      )).expand(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.green,
          selectedItemColor: Colors.lightBlue,
          currentIndex: curr_index,
          iconSize: 30,
          onTap: (value) {
            curr_index = value;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), tooltip: "Home Page", label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.location_on),
                tooltip: "Map View",
                label: "Location"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                tooltip: "Calendar View",
                label: "Calendar"),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                tooltip: "Account Page",
                label: "Account")
          ]),
    );
  }
}
