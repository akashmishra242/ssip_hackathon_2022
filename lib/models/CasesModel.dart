import 'dart:convert';

class Case_model {
  final String animal;
  final String disease;
  final String Doctor;
  final DateTime date;
  final String place;
  bool completed = false;

  Case_model({
    required this.animal,
    required this.disease,
    required this.Doctor,
    required this.date,
    required this.place,
  });

  Map<String, dynamic> toMap() {
    return {
      'animal': animal,
      'disease': disease,
      'Doctor': Doctor,
      'date': date.millisecondsSinceEpoch,
      'place': place,
      'completed': completed,
    };
  }

  factory Case_model.fromMap(Map<String, dynamic> map) {
    return Case_model(
      animal: map['animal'] ?? '',
      disease: map['disease'] ?? '',
      Doctor: map['Doctor'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      place: map['place'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Case_model.fromJson(String source) =>
      Case_model.fromMap(json.decode(source));
}
