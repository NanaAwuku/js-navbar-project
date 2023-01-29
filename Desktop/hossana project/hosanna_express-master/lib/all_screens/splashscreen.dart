import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosanna_shuttle/all_screens/loginScreen.dart';
import 'package:hosanna_shuttle/controllers/general_controller.dart';
import 'package:hosanna_shuttle/utils/Prefs.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final generalController = Get.find<GeneralController>();
    generalController.splashScreenTimeout();

    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        decoration: BoxDecoration(
          image : DecorationImage(
            image: AssetImage("images/splash_1.png"), 
            fit: BoxFit.cover)
            ),
    
          child: Center(
            child: Image.asset(
                "images/hosanna_white.png",
                height: 200.0,
              ),
          ),
            // Logo for Splash Screen
           
       
      ),
      );
    
  }
}
