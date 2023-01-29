import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hosanna_shuttle/all_screens/mainscreen.dart';
import 'package:hosanna_shuttle/all_screens/registrationScreen.dart';
import 'package:hosanna_shuttle/controllers/general_controller.dart';
import 'package:hosanna_shuttle/pages/otp.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final generalController = Get.find<GeneralController>();
    final TextEditingController phoneNoController = new TextEditingController();
    final TextEditingController passwordController =
        new TextEditingController();

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
                    "Hi there, nice to meet you!",
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                Text(
                  "Get moving with Hosanna Express",
                  style: TextStyle(
                    fontFamily: 'Eculid Circular B Bold',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 32.0,
                ),
                TextFormField(
                  controller: phoneNoController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone number',
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
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 5),
                  child: ElevatedButton(
                    child: Text("Sign In"),
                    onPressed: () {
                      if (phoneNoController.value.text.isEmpty ||
                          passwordController.value.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "All fields are required",
                            backgroundColor: Colors.red[400],
                            textColor: Colors.white);
                      } else {
                        generalController.login(
                            context,
                            phoneNoController.value.text,
                            passwordController.value.text);
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
                TextButton(
                  onPressed: () {
                    generalController.canResendOtp.value = false;
                    Get.to(()=> const Otp());
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                          child: Text(
                            "Forget Password",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Euclid Circular B Bold',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.0),
                Center(
                  child: TextButton(
                    onPressed: () => Get.to(() => const RegistrationScreen()),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          children: [
                            TextSpan(
                              text: 'Do not have an Account?' + " ",
                            ),
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Euclid Circular B Bold',
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ],
            )),
          )),
    );
  }
}
