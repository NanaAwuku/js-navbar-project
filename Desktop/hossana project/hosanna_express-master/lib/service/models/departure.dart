// To parse this JSON data, do
//
//     final subscription = subscriptionFromJson(jsonString);

import 'dart:convert';

List<Departure> departureFromJson(String str) =>
    List<Departure>.from(json.decode(str).map((x) => Departure.fromJson(x)));

String departureFromToJson(List<Departure> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Departure {
  Departure({
    required this.code,
    required this.rtCode,
    required this.date,
    required this.time,
    required this.status,
  });

  String code;
  String rtCode;
  String date;
  String time;
  String status;

  factory Departure.fromJson(Map<String, dynamic> json) => Departure(
        code: json["TD_CODE"],
        rtCode: json["TD_RTCODE"],
        date: json["TD_DATE"],
        time: json["TD_TIME"],
        status: json["TD_STATUS"],
      );

  Map<String, dynamic> toJson() => {
        "TD_CODE": code,
        "TD_RTCODE": rtCode,
        "TD_DATE": date,
        "TD_TIME": time,
        "TD_STATUS": status,
      };
}
