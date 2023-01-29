import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hosanna_shuttle/controllers/general_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../all_widgets/Divider.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final generalController = Get.find<GeneralController>();
    return Obx(() => Scaffold(
      backgroundColor: Colors.grey[100],
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
          "Check-In Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.6,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 130.0,
              child: WebView(
                initialUrl:
                'https://www.google.com/maps/d/embed?mid=1oaCuHydUZQRor_8PdulC3arB_HklX6M&hl=en&ehbc=2E312F&z=12&ll=5.667976173575658%2C-0.30214582031248494',
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Summary",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Euclid Circular B Bold',
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 5.0),
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
                                  generalController.selectedRoute.value == null ? "" : generalController.selectedRoute.value!.rtName.split('-')[0],
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(height: 2.0),
                                /*Text(
                                  "7:38",
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black54,
                                  ),
                                ),*/
                                SizedBox(height: 16.0),
                                Text(
                                  generalController.selectedRoute.value == null ? "" : generalController.selectedRoute.value!.rtName.split('-')[1],
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(height: 2.0),
                                /*Text(
                                  "10:49",
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.black54),
                                ),*/
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pickup Point",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            generalController.selectedBusStop.value == null ? "" : generalController.selectedBusStop.value!.rtbName!,
                            style: TextStyle(fontSize: 16.0),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: DividerWidget(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Subscription Type",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            generalController.selectedSubscription.value == null ? "" : generalController.selectedSubscription.value!.blName,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: DividerWidget(),
                    ),
                   
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: DividerWidget(),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: ElevatedButton(
                        child: Text("Proceed to Payment"),
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black87,
                          fixedSize: Size(400, 60),
                          textStyle: TextStyle(
                            fontSize: 16.0,
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
          ],
        ),
      ),
    ));
  }
}
