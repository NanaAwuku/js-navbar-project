import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ndialog/ndialog.dart';

class Utils{

  static showProgressDialog(context){
    CustomProgressDialog progressDialog = CustomProgressDialog(
      context,
      dismissable: false,
      loadingWidget: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
              ),
              padding: const EdgeInsets.all(20),
              child: const CircularProgressIndicator( color: Colors.white,)
          ),
        ),
      ),
    );
    progressDialog.show();
  }

  static dismissProgressPopup(context){
    Navigator.of(context).pop();
  }

  static String formatTimestampDate(int timestamp) {
    var format = DateFormat('dd MMM, yyyy'); // <- use skeleton here
    return format.format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  static String formatTimestampTime(int timestamp) {
    var format = DateFormat('HH:mm'); // <- use skeleton here
    return format.format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  static String formatTimestampDateTime(int timestamp) {
    var format = DateFormat('dd MMM, yyyy HH:mm'); // <- use skeleton here
    return format.format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  }

  static String formatCreatedAt(String date) {
    var format = DateFormat('dd MMM, yyyy'); // <- use skeleton here
    return format.format(DateTime.parse(date));
  }

  static showNotification(){

  }

  static String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("HH:mm").format(now);
  }

}