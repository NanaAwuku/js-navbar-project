import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hosanna_shuttle/pages/edit_profile.dart';
import 'package:hosanna_shuttle/pages/subscriptions.dart';
import 'package:hosanna_shuttle/all_Screens/map_screen.dart';
import 'package:hosanna_shuttle/pages/notification.dart';
import 'package:hosanna_shuttle/pages/transactions.dart';
import 'package:hosanna_shuttle/pages/trips.dart';
import 'package:hosanna_shuttle/pages/route.dart';
import 'package:hosanna_shuttle/pages/about.dart';
import 'package:hosanna_shuttle/pages/check_in.dart';
import 'package:hosanna_shuttle/pages/support.dart';
import 'package:hosanna_shuttle/model/dialog.dart';
import 'package:get/get.dart';
import 'package:hosanna_shuttle/all_Screens/loginScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../all_widgets/Divider.dart';
import '../utils/Prefs.dart';
import 'package:hosanna_shuttle/controllers/general_controller.dart';
import '../utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final generalController = Get.find<GeneralController>();
  final Uri whatsapp = Uri.parse('https://wa.me/1241699096');
  String title = 'AlertDialog';
  bool tappedYes = false;
  DateTime? currentBackPressTime;
  // Future<String> name = Prefs.getString(kUserFirstName);

  String _firstName = '';
  String _lastName = '';
  String _routeCode = '';
  bool _hasRoute = false;
  String _rountName = '';
  String routeName = '';

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  _MainScreenState() {
    Prefs.getString(kUserFirstName).then((value) => setState(() {
          _firstName = value.toUpperCase();
        }));

    Prefs.getString(kUserLastName).then((value) => setState(() {
          _lastName = value.toUpperCase();
        }));

    Prefs.getString(kRouteCode).then((value) => setState(() {
          _routeCode = value;
        }));

    Prefs.getBoolean(kRouteStatus).then((value) => setState(() {
          _hasRoute = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    generalController.getRoutes();
    generalController.getBusStops();
    generalController.getSubscriptions();
    generalController.getDepartureTime(_routeCode);
    generalController.getSelectedRoute(_routeCode);

    // setState(() {
    //   _rountName = userRoute;
    // });

    routeName = generalController.selectedBusStop == null
        ? ""
        : generalController.selectedBusStop.value == null
            ? ""
            : generalController.selectedBusStop.value!.rtbName;

    // generalController.selectedBusStop.value!.rtbName;

    // generalController.selectedBusStop.value!.rtbName;

    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        color: Colors.white,
        width: 260.0,
        child: Drawer(
          child: ListView(
            children: [
              //Drawer Header
              Container(
                height: 95.0,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        (2 + 2 == 4) ? "images/user.png" : "",
                        height: 65.0,
                        width: 65.0,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfile(),
                              ));
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$_firstName $_lastName',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Euclid Circular B Bold',
                              ),
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              "Edit profile",
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // DividerWidget(),
              // SizedBox(
              //   height: 12.0,
              // ),

              // Drawer Body Controllers
              ListTile(
                leading: Icon(
                  Icons.payment,
                ),
                title: Text(
                  "Subscriptions",
                  style: TextStyle(fontSize: 16.0),
                ),
                onTap: (() {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Subscriptions()));
                }),
              ),

              ListTile(
                leading: Icon(
                  Icons.location_pin,
                ),
                title: Text(
                  "Check-in",
                  style: TextStyle(fontSize: 16.0),
                ),
                //checking if user have
                onTap: (_hasRoute
                    ? () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Check_in()));
                      }
                    : () {
                        Fluttertoast.showToast(
                            msg:
                                "You need to have a valid subscription to check-in",
                            backgroundColor: Colors.red[400],
                            textColor: Colors.white,
                            timeInSecForIosWeb: 1,
                            fontSize: 16.0);
                      }),
              ),

              ListTile(
                leading: Icon(
                  Icons.money_outlined,
                ),
                title: Text(
                  "Billing",
                  style: TextStyle(fontSize: 16.0),
                ),
                onTap: (() {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Transactions()));
                }),
              ),
              ListTile(
                leading: Icon(
                  Icons.trip_origin_outlined,
                ),
                title: Text(
                  "History",
                  style: TextStyle(fontSize: 16.0),
                ),
                onTap: (() {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Trips()));
                }),
              ),

              ListTile(
                leading: Icon(
                  Icons.notifications_outlined,
                ),
                title: Text(
                  "Notifications",
                  style: TextStyle(fontSize: 16.0),
                ),
                onTap: (() {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Notifications()));
                }),
              ),

              ListTile(
                leading: Icon(
                  Icons.contact_support_outlined,
                ),
                title: Text(
                  "Support",
                  style: TextStyle(fontSize: 16.0),
                ),
                onTap: (() {
                  Navigator.pop(context);
                  launchUrl(whatsapp);
                  ;
                }),
              ),
              ListTile(
                leading: Icon(
                  Icons.info_outline,
                ),
                title: Text(
                  "About",
                  style: TextStyle(fontSize: 16.0),
                ),
                onTap: (() {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => About()));
                }),
              ),
              InkWell(
                child: ListTile(
                  leading: Icon(
                    Icons.logout_sharp,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  onTap: () async {
                    final action = await AlertDialogs.yesCancelDialog(
                        context,
                        Icon(Icons.logout_outlined, size: 60),
                        'Are you sure you want to logout ?');
                    if (action == DialogsAction.yes) {
                      Prefs.setBoolean(kIsLoggedIn, false);
                      Get.offAll(() => const LoginScreen());
                    } else {
                      setState(() => tappedYes = false);
                    }
                  },
                  //  (() {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => LoginScreen(),
                  //     ));
                  // }),
                ),
              ),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Stack(
          children: [
            // WebView(
            //   javascriptMode: JavascriptMode.unrestricted,
            //   initialUrl:
            //       'https://www.google.com/maps/d/embed?mid=1oaCuHydUZQRor_8PdulC3arB_HklX6M&hl=en&ehbc=2E312F&z=12&ll=5.667976173575658%2C-0.30214582031248494',
            // ),
            MapScreen(),
            Positioned(
              top: 36.0,
              left: 20.0,
              child: GestureDetector(
                onTap: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 16.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    radius: 23.0,
                  ),
                ),
              ),
            ),

            //buttom navigator
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedSize(
                curve: Curves.easeInOut,
                duration: new Duration(milliseconds: 560),
                child: Container(
                  height: 280.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 12.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 16, 30, 16),
                          child: ElevatedButton(
                            child: Text("Renew Subscription"),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Subscriptions(),
                                  ));
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: DividerWidget(),
                        ),
                        SizedBox(
                          height: 12.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Routes",
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Euclid Circular B Bold',
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30.0, top: 5.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Image.asset(
                                    "assets/originDestinationDistanceIcon.png",
                                    fit: BoxFit.cover,
                                    height: 80,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nsawam",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    SizedBox(height: 2.0),
                                    Text(
                                      "7:38",
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    Text(
                                      "Accra Central",
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    SizedBox(height: 2.0),
                                    Text(
                                      "10:49",
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    try {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(
            msg: "Press back again to exit",
            backgroundColor: Colors.black54,
            textColor: Colors.white);
        return Future.value(false);
      }
      return Future.value(true);
    } catch (Exc) {
      return Future.value(false);
    }
  }
}
