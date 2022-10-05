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
    required this.animal,
    required this.disease,
    required this.Doctor,
    required this.date,
    required this.place,
    required this.completed,
  });

  String animal;
  String disease;
  String Doctor;
  DateTime date;
  String place;
  bool completed;

  factory Case_model.fromJson(Map<String, dynamic> json) => Case_model(
        animal: json["animal"],
        disease: json["disease"],
        Doctor: json["Doctor"],
        date: DateTime.fromMillisecondsSinceEpoch(json["date"]),
        place: json["place"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "animal": animal,
        "disease": disease,
        "Doctor": Doctor,
        "date": date.millisecondsSinceEpoch,
        "place": place,
        "completed": completed,
      };
}
