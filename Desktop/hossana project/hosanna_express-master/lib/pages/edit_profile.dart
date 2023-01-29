import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController dateController = TextEditingController();

  void iniState() {
    super.initState();
    dateController.text = "";
  }

  _EditProfileState() {
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: (() {
            Navigator.pop(context);
          }),
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Euclid Circular B Bold',
          ),
        ),
        elevation: 0.6,
        titleSpacing: 20.0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 16, right: 16),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130.0,
                    height: 130.0,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 9,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10)),
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          (2 + 2 == 4) ? "images/user.png" : "",
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 80,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 3,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        color: Colors.purple,
                      ),
                      child: InkWell(
                        onTap: () {
                          _showBottomSheet();
                        },
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 52.0,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
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
                    keyboardType: TextInputType.text,
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
              height: 20.0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  isDense: true,
                  prefixIcon: Icon(Icons.date_range),
                  prefixIconColor: Colors.black,
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
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Phone No',
                // prefixIcon: Icon(Icons.person_add),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                isDense: true,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
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
              height: 44.0,
            ),
            ElevatedButton(
              child: Text("Update"),
              onPressed: () {
                Navigator.pop(context);
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
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
            ),

            // SizedBox(
            //   height: 12.0,
            // ),
            // TextFormField(
            //   keyboardType: TextInputType.text,
            //   decoration: InputDecoration(
            //     labelText: 'Occupation',
            //     // prefixIcon: Icon(Icons.person_add),
            //     border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10.0)),
            //     isDense: true,
            //   ),
            // ),
            // SizedBox(
            //   height: 12.0,
            // ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        builder: (_) {
          return ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            children: [
              Text(
                'Pick Profile Picture',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                      fixedSize: Size(90, 90),
                    ),
                    onPressed: () {},
                    child: Image.asset('images/add_image.png'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                      fixedSize: Size(90, 90),
                    ),
                    onPressed: () {},
                    child: Image.asset('images/camera.png'),
                  )
                ],
              )
            ],
          );
        });
  }
}
