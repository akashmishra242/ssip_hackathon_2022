// To parse this JSON data, do
//
//     final caseModel = caseModelFromJson(jsonString);

import 'dart:convert';

List<Case_model> caseModelFromJson(String str) =>
    List<Case_model>.from(json.decode(str).map((x) => Case_model.fromJson(x)));

String caseModelToJson(List<Case_model> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Case_model {
  Case_model({
    required this.id,
    required this.animal,
    required this.disease,
    required this.Doctor,
    required this.date,
    required this.month,
    required this.year,
    required this.state,
    required this.breed,
    required this.completed,
    required this.place,
    this.ownerName,
    this.ownerMobileNo,
    this.diseaseDesc,
  });

  String id;
  String animal;
  String disease;
  String Doctor;
  String date;
  String month;
  String year;
  String state;
  String breed;
  bool completed;
  String? ownerName;
  String? ownerMobileNo;
  String? diseaseDesc;
  String place;

  factory Case_model.fromJson(Map<String, dynamic> json) => Case_model(
        id: json["id"],
        animal: json["animal"],
        disease: json["disease"],
        Doctor: json["Doctor"],
        date: json["date"],
        month: json["month"],
        year: json["year"],
        state: json["state"],
        breed: json["breed"],
        completed: json["completed"],
        ownerName: json["owner_name"],
        ownerMobileNo: json["owner_mobile_no"],
        diseaseDesc: json["disease_desc"],
        place: json["place"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "animal": animal,
        "disease": disease,
        "Doctor": Doctor,
        "date": date,
        "month": month,
        "year": year,
        "state": state,
        "breed": breed,
        "completed": completed,
        "owner_name": ownerName,
        "owner_mobile_no": ownerMobileNo,
        "disease_desc": diseaseDesc,
        "place": place,
      };
}
