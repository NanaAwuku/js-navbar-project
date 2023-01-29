import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hosanna_shuttle/controllers/general_controller.dart';
import 'package:hosanna_shuttle/pages/checkin_details.dart';
import 'package:hosanna_shuttle/utils/Prefs.dart';
import 'package:hosanna_shuttle/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Check_in extends StatefulWidget {
  const Check_in({Key? key}) : super(key: key);

  @override
  State<Check_in> createState() => _Check_inState();
}

class _Check_inState extends State<Check_in> {
  final generalController = Get.find<GeneralController>();

  String _routeCode = '';
  var selectedRoute = '';
  var selectedBusStop = '';
  var selectedDeparture = '';

  _Check_inState() {
    Prefs.getString(kRouteCode).then((value) => setState(() {
          selectedRoute = value;
          generalController.setSelectedRoute("${value}");
          generalController.selectedBusStop.value = null;
          generalController.loadBusStops("${value}");
        }));
  }

  @override
  Widget build(BuildContext context) {
    generalController.loadRoutes();
    generalController.loadSubscriptions();
    generalController.loadDepartureTime();

    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: (() {
              Navigator.pop(context);
            }),
          ),
          title: Text(
            "Check-in",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.only(right: 10.0),
              alignment: Alignment.center,
              child: TextButton(
                child: Text("New +"),
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
          elevation: 0.6,
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() => Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                            child: Column(children: [
                          Column(
                            children: [
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      DropdownButtonFormField(
                                        isDense: true,
                                        value: selectedRoute == ""
                                            ? null
                                            : selectedRoute,
                                        items:
                                            generalController.routesList.value,
                                        onChanged: null,
                                        icon: const Icon(
                                          Icons.arrow_drop_down_circle,
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: "Select a Route",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          isDense: true,
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      DropdownButtonFormField(
                                        isDense: true,
                                        value: selectedBusStop == ""
                                            ? null
                                            : selectedBusStop,
                                        items:
                                            generalController.busStopList.value,
                                        onChanged: (val) {
                                          setState(() {
                                            selectedBusStop = "${val}";
                                          });
                                          generalController
                                              .setSelectedBusStop("${val}");
                                        },
                                        icon: const Icon(
                                          Icons.arrow_drop_down_circle,
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: "Pickup Location",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          isDense: true,
                                        ),
                                      ),
                                      SizedBox(height: 20.0),
                                      generalController.selectedBusStop.value ==
                                              null
                                          ? Container()
                                          : generalController.selectedBusStop
                                                      .value!.rtbPicture ==
                                                  null
                                              ? Container()
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 20),
                                                  height: 200.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                          offset:
                                                              Offset(2.0, 2.0),
                                                          blurRadius: 5.0,
                                                          spreadRadius: 0.5),
                                                    ],
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    child: CachedNetworkImage(
                                                      height: 200,
                                                      width: double.infinity,
                                                      imageUrl: generalController
                                                                  .selectedBusStop
                                                                  .value ==
                                                              null
                                                          ? ""
                                                          : generalController
                                                                      .selectedBusStop
                                                                      .value!
                                                                      .rtbPicture ==
                                                                  null
                                                              ? ""
                                                              : generalController
                                                                  .selectedBusStop
                                                                  .value!
                                                                  .rtbPicture!,
                                                      placeholder:
                                                          (context, url) =>
                                                              Container(
                                                        width: double.infinity,
                                                        height: 200,
                                                        child: Center(
                                                          child: SizedBox(
                                                              height: 30,
                                                              width: 30,
                                                              child:
                                                                  CircularProgressIndicator()),
                                                        ),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Container(),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                      SizedBox(height: 20.0),
                                      DropdownButtonFormField(
                                        isDense: true,
                                        value: selectedDeparture == ""
                                            ? null
                                            : selectedDeparture,
                                        items: generalController
                                            .departureList.value,
                                        onChanged: (val) {
                                          setState(() {
                                            selectedDeparture = "${val}";
                                          });
                                          generalController
                                              .setSelectedDeparture("${val}");
                                        },
                                        icon: const Icon(
                                          Icons.arrow_drop_down_circle,
                                          color: Colors.black,
                                        ),
                                        decoration: InputDecoration(
                                          labelText: "Departure Time",
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          isDense: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ])),
                        flex: 2),
                    Expanded(
                      child: Container(
                          child: ElevatedButton(
                            child: Text("Check-In"),
                            onPressed: () {
                              if (selectedRoute == "" ||
                                  selectedBusStop == "" ||
                                  selectedDeparture == "") {
                                Fluttertoast.showToast(
                                    msg: "All fields are required",
                                    textColor: Colors.white);
                              } else {
                                generalController.checkIn(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green,
                              fixedSize: Size(400, 60),
                              textStyle: TextStyle(
                                fontSize: 20.0,
                              ),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                          ),
                          alignment: Alignment.bottomCenter),
                      flex: 0,
                    )
                  ],
                )),
          ),
        ),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 80.0),
          child: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            backgroundColor: Colors.blueAccent,
            child: SvgPicture.asset(
              "assets/plus_icon.svg",
              color: Colors.white,
              semanticsLabel: 'New Check-in',
              height: 24.0,
              width: 24.0,
            ),
          ),
        ));
  }
}
