// To parse this JSON data, do
//
//     final userProfile = userProfileFromJson(jsonString);

import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    required this.fname,
    required this.lname,
    required this.gender,
    required this.email,
    required this.phoneno,
    this.userapikey,
    required this.clientid,
  });

  String fname;
  String lname;
  String gender;
  String email;
  String phoneno;
  dynamic userapikey;
  String clientid;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    fname: json["fname"],
    lname: json["lname"],
    gender: json["gender"],
    email: json["email"],
    phoneno: json["phoneno"],
    userapikey: json["userapikey"],
    clientid: json["clientid"],
  );

  Map<String, dynamic> toJson() => {
    "fname": fname,
    "lname": lname,
    "gender": gender,
    "email": email,
    "phoneno": phoneno,
    "userapikey": userapikey,
    "clientid": clientid,
  };
}
