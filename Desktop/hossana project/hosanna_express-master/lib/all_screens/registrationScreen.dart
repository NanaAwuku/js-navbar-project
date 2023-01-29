import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hosanna_shuttle/all_screens/loginScreen.dart';
import 'package:intl/intl.dart';
import 'package:hosanna_shuttle/all_screens/mainscreen.dart';

import '../controllers/general_controller.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final generalController = Get.find<GeneralController>();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastnameController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController dateController = TextEditingController();

  void iniState() {
    super.initState();
    dateController.text = "";
  }

  _RegistrationScreenState() {
    _selectedVal = _genderList[0];
  }

  final _genderList = [
    "Male",
    "Female",
    "Other",
  ];

  String? _selectedVal = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildRegistrationView(),
      ),
    );
  }

  _buildRegistrationView(){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 18),
        child: Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Image.asset(
                "images/hosanna.png",
                height: 90,
                fit: BoxFit.scaleDown,
              ),
              SizedBox(
                height: 1.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 25, 0, 5),
                child: Center(
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                        fontSize: 22.0, fontFamily: 'Euclid Circular B Bold'),
                    // textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: firstNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Firstname',
                        // prefixIcon: Icon(Icons.person_add),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        isDense: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: lastnameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Lastname',
                        // prefixIcon: Icon(Icons.person_add),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextFormField(
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    isDense: true,
                    //prefixIcon: Icon(Icons.date_range),
                    //prefixIconColor: Colors.black,
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      String formattedDate =
                      DateFormat("dd-MM-yyyy").format(pickedDate);
                      setState(() {
                        dateController.text = formattedDate.toString();
                      });
                    } else {
                      print("Not selected");
                    }
                  },
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              DropdownButtonFormField(
                isDense: true,
                value: _selectedVal,
                items: _genderList
                    .map(
                      (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedVal = val as String;
                  });
                },
                icon: const Icon(
                  Icons.arrow_drop_down_circle,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: "Gender",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  isDense: true,
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone No.',
                    // prefixIcon: Icon(Icons.person_add),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
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
                padding: EdgeInsets.fromLTRB(0, 30, 0, 5),
                child: ElevatedButton(
                  child: Text("Create an Account"),
                  onPressed: () {
                    if (firstNameController.value.text.isEmpty ||
                        lastnameController.value.text.isEmpty ||
                        emailController.value.text.isEmpty ||
                        phoneController.value.text.isEmpty ||
                        dateController.value.text.isEmpty ) {
                      Fluttertoast.showToast(
                          msg: "All fields are required",
                          backgroundColor: Colors.red[400],
                          textColor: Colors.white);
                    } else {
                      generalController.register(
                          context,
                          firstNameController.value.text,
                          lastnameController.value.text,
                          dateController.value.text,
                          _selectedVal!,
                          phoneController.value.text,
                          emailController.value.text
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black87,
                    padding: EdgeInsets.all(20.0),
                    fixedSize: Size(400, 60),
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    // side: BorderSide(
                    //   color: Colors.black87,
                    //   width: 4,
                    // ),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
              ),
              Center(
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        children: [
                          TextSpan(
                            text: 'Already have an Account?' + " ",
                          ),
                          TextSpan(
                            text: 'Sign In',
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
          ),
        ),
      ),
    );
  }

}
