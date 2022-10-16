class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? phoneno;
  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.secondName,
    this.phoneno,
  });

//data to Server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'phoneno': phoneno,
    };
  }

//data from Server
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      phoneno: map['phoneno'],
    );
  }
}
