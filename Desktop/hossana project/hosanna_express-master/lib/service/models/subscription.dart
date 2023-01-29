// To parse this JSON data, do
//
//     final subscription = subscriptionFromJson(jsonString);

import 'dart:convert';

List<Subscription> subscriptionFromJson(String str) => List<Subscription>.from(json.decode(str).map((x) => Subscription.fromJson(x)));

String subscriptionToJson(List<Subscription> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Subscription {
  Subscription({
    required this.blId,
    required this.blCode,
    required this.blName,
  });

  String blId;
  String blCode;
  String blName;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    blId: json["BL_ID"],
    blCode: json["BL_CODE"],
    blName: json["BL_NAME"],
  );

  Map<String, dynamic> toJson() => {
    "BL_ID": blId,
    "BL_CODE": blCode,
    "BL_NAME": blName,
  };
}
