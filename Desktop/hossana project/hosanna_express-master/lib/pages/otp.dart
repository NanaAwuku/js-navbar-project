import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hosanna_shuttle/controllers/general_controller.dart';
import 'package:hosanna_shuttle/pages/verification.dart';

class Otp extends StatelessWidget {
  const Otp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final generalController = Get.find<GeneralController>();
    final phoneController = TextEditingController();

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
                    "Forgot Password?",
                    style: TextStyle(
                      fontFamily: 'Eculid Circular B Bold',
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Enter Phone Number',
                    // prefixIcon: Icon(Icons.person_add),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    isDense: true,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 5),
                  child: ElevatedButton(
                    child: Text("Submit"),
                    onPressed: () {
                      if(phoneController.value.text.isEmpty){
                        Fluttertoast.showToast(
                          msg: "Phone number is required",
                          textColor: Colors.white
                        );
                      }else{
                        generalController.sendOtp(context, phoneController.value.text.trim());
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
