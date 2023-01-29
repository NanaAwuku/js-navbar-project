import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hosanna_shuttle/all_screens/splashscreen.dart';
import 'package:get/get.dart';
import 'package:hosanna_shuttle/controllers/general_controller.dart';
import 'package:hosanna_shuttle/utils/HexColor.dart';

Future<void> main() async{
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(GeneralController());
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hosanna Express Shuttle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: HexColor.generateMaterialColor('#000000'),
          fontFamily: "Euclid Circular B Regular",
          visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: SplashScreen(),
    );
  }
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
