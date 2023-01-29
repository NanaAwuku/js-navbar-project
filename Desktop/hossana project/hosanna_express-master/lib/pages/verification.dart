import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hosanna_shuttle/controllers/general_controller.dart';
import 'package:hosanna_shuttle/utils/Utils.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Verification extends StatefulWidget {
  final String phoneNumber;
  const Verification({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {

  final generalController = Get.find<GeneralController>();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.all(24.0),
            child: Expanded(
                child: Column(
              children: [
                SizedBox(
                  height: 60.0,
                ),
                Image.asset(
                  "images/hosanna.png",
                  height: 90,
                  fit: BoxFit.scaleDown,
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 5),
                  child: Text(
                    "Verification",
                    style: TextStyle(
                      fontFamily: 'Eculid Circular B Bold',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "Please enter the code sent to your mobile number ${widget.phoneNumber}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                  // textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 32.0,
                ),
                TextFormField(
                  controller: otpController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'OTP',
                    // prefixIcon: Icon(Icons.person_add),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    isDense: true,
                  ),
                ),
                SizedBox(
                  height: 28.0,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    // prefixIcon: Icon(Icons.person_add),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    isDense: true,
                  ),
                ),
                SizedBox(
                  height: 28.0,
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    // prefixIcon: Icon(Icons.person_add),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    isDense: true,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 5),
                  child: ElevatedButton(
                    child: Text("Confirm"),
                    onPressed: () {
                      if(otpController.value.text.isEmpty || passwordController.value.text.isEmpty ||
                      confirmPasswordController.value.text.isEmpty){
                        Fluttertoast.showToast(
                          msg: "All fields are required",
                          textColor: Colors.white
                        );
                      }else{
                        if(passwordController.value.text.trim() == confirmPasswordController.value.text){
                          generalController.verifyOtp(
                            context, widget.phoneNumber, passwordController.value.text.trim(),
                            otpController.value.text.trim()
                          );
                        }else{
                          Fluttertoast.showToast(
                            msg: "Passwords must be the same",
                            textColor: Colors.white
                          );
                        }

                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black87,
                      fixedSize: Size(400, 60),
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      // side: BorderSide(
                      //   color: Colors.black,
                      //   width: 2,
                      // ),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                ),

                Obx(() => Center(
                  child: TextButton(
                      onPressed: (){
                        if(generalController.canResendOtp.value){
                          generalController.sendOtp(
                            context, widget.phoneNumber
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Didn't receive a verification code?",
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(width: 5,),
                          generalController.canResendOtp.value ?
                          Text(
                            'Resend',
                            style: TextStyle(
                                color: Colors.pinkAccent
                            ),
                          ) :
                          Countdown(
                            seconds: 120,
                            build: (BuildContext context, double time){
                              return Text(
                                time.toString(),
                                //"${time.minutes.toString().length == 1 ? "0${time.minutes}": time.minutes}",
                                style: TextStyle(
                                  color: Colors.pinkAccent
                                ),
                              );
                            },
                            onFinished: () {
                              generalController.canResendOtp.value = true;
                            },
                          )

                        ],
                      )
                  ),
                ))

              ],
            )),
          )),
    );
  }

}
