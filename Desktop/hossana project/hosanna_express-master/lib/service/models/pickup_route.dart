// To parse this JSON data, do
//
//     final routes = routesFromJson(jsonString);

import 'dart:convert';

List<PickUpRoute> routesFromJson(String str) => List<PickUpRoute>.from(json.decode(str).map((x) => PickUpRoute.fromJson(x)));

String routesToJson(List<PickUpRoute> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PickUpRoute {
  PickUpRoute({
    required this.rtCode,
    required this.rtName,
    this.rtDescription,
    this.rtMaplink,
    this.rtMapLinkMobile
  });

  String rtCode;
  String rtName;
  String? rtDescription;
  String? rtMaplink;
  String? rtMapLinkMobile;

  factory PickUpRoute.fromJson(Map<String, dynamic> json) => PickUpRoute(
    rtCode: json["RT_CODE"],
    rtName: json["RT_NAME"],
    rtDescription: json["RT_DESCRIPTION"],
    rtMaplink: json["RT_MAPLINK"],
    rtMapLinkMobile: json["RT_MAPLINKMOBILE"],
  );

  Map<String, dynamic> toJson() => {
    "RT_CODE": rtCode,
    "RT_NAME": rtName,
    "RT_DESCRIPTION": rtDescription,
    "RT_MAPLINK": rtMaplink,
    "RT_MAPLINKMOBILE": rtMapLinkMobile,
  };
}
