// To parse this JSON data, do
//
//     final busStop = busStopFromJson(jsonString);

import 'dart:convert';

List<BusStop> busStopFromJson(String str) => List<BusStop>.from(json.decode(str).map((x) => BusStop.fromJson(x)));

String busStopToJson(List<BusStop> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BusStop {
  BusStop({
    required this.rtbId,
    required this.rtbCode,
    required this.rtbRtcode,
    required this.rtbName,
    this.rtbPosition,
    this.rtbPicture,
  });

  String rtbId;
  String rtbCode;
  String rtbRtcode;
  String rtbName;
  String? rtbPosition;
  String? rtbPicture;

  factory BusStop.fromJson(Map<String, dynamic> json) => BusStop(
    rtbId: json["RTB_ID"],
    rtbCode: json["RTB_CODE"],
    rtbRtcode: json["RTB_RTCODE"],
    rtbName: json["RTB_NAME"],
    rtbPosition: json["RTB_POSITION"],
    rtbPicture: json["RTB_PICTURE"] == null ? null : json["RTB_PICTURE"],
  );

  Map<String, dynamic> toJson() => {
    "RTB_ID": rtbId,
    "RTB_CODE": rtbCode,
    "RTB_RTCODE": rtbRtcode,
    "RTB_NAME": rtbName,
    "RTB_POSITION": rtbPosition,
    "RTB_PICTURE": rtbPicture == null ? null : rtbPicture,
  };
}
