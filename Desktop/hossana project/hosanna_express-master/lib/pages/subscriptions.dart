import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hosanna_shuttle/controllers/general_controller.dart';
import 'package:hosanna_shuttle/pages/paynow.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Subscriptions extends StatefulWidget {
  const Subscriptions({Key? key}) : super(key: key);

  @override
  State<Subscriptions> createState() => _SubscriptionsState();
}

class _SubscriptionsState extends State<Subscriptions> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  final generalController = Get.find<GeneralController>();
  var selectedRoute = '';
  //var selectedBusStop = '';
  var selectedSubscription = '';

  var isPageLoadingWebview = true;

  @override
  void initState() {
    generalController.selectedRoute.value = null;
    generalController.selectedSubscription.value = null;
    generalController.selectedBusStop.value = null;
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    generalController.loadRoutes();
    generalController.loadSubscriptions();

    return Scaffold(
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
          "Subscriptions",
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
        child: Obx(()=> Column(
          children: [
            Expanded(child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    generalController.selectedRoute.value == null ? Container():
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5.0,
                            spreadRadius: 0.5,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Stack(
                          children: [
                            WebView(
                              initialUrl: generalController.selectedRoute.value!.rtMapLinkMobile,
                              javascriptMode: JavascriptMode.unrestricted,
                              onWebViewCreated: (WebViewController webViewController) {
                                _controller.complete(webViewController);
                              },
                              onProgress: (int progress) {
                                if(progress > 90){
                                  setState(() {
                                    isPageLoadingWebview = false;
                                  });
                                }
                                //print('WebView is loading (progress : $progress%)');
                              },
                              onPageStarted: (String url) {
                                print('Page started loading: $url');
                              },
                              onPageFinished: (String url) {
                                print('Page finished loading: $url');
                              },
                              gestureNavigationEnabled: true,
                              backgroundColor: Colors.white,
                            ),
                            isPageLoadingWebview ? const Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              ),
                            ) : Container()
                          ],
                        ),
                      ),
                    ),
                    generalController.selectedRoute.value == null ? Container() : SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5.0,
                            spreadRadius: 0.5,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20.0,
                            ),
                            DropdownButtonFormField(
                              isDense: true,
                              value: selectedRoute == "" ? null : selectedRoute,
                              items: generalController.routesList.value,
                              onChanged: (val) {
                                setState(() {
                                  selectedRoute = "${val}";
                                  //selectedBusStop = '';
                                });
                                generalController.setSelectedRoute("${val}");
                                generalController.selectedBusStop.value = null;
                                generalController.loadBusStops("${val}");
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down_circle,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                labelText: "Select a Route",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                isDense: true,
                              ),
                            ),
                            SizedBox(height: 20.0),
                            /*SizedBox(
                              height: 20.0,
                            ),
                            DropdownButtonFormField(
                              isDense: true,
                              value: selectedBusStop == "" ? null : selectedBusStop,
                              items: generalController.busStopList.value,
                              onChanged: (val) {
                                setState(() {
                                  selectedBusStop = "${val}";
                                });
                                generalController.setSelectedBusStop("${val}");
                              },
                              icon: const Icon(
                                Icons.arrow_drop_down_circle,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                labelText: "Pickup Location",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                isDense: true,
                              ),
                            ),
                            SizedBox(height: 20.0),*/
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    generalController.selectedBusStop.value == null ?
                    Container() : generalController.selectedBusStop.value!.rtbPicture == null ?
                    Container() : Container(
                      margin: EdgeInsets.only(bottom: 20),
                      height: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(2.0, 2.0),
                              blurRadius: 5.0,
                              spreadRadius: 0.5),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          height: 200,
                          width: double.infinity,
                          imageUrl: generalController.selectedBusStop.value == null ? "" : generalController.selectedBusStop.value!.rtbPicture == null ? "" : generalController.selectedBusStop.value!.rtbPicture!,
                          placeholder: (context, url) => Container(
                            width: double.infinity,
                            height: 200,
                            child: Center(
                              child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator()
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>  Container(),
                          fit: BoxFit.cover,
                          /*imageBuilder: (context, imageProvider) => CircleAvatar(
                            radius: 20,
                            backgroundImage: imageProvider,
                          ),*/
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 120.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 5.0,
                                spreadRadius: 0.5,
                                offset: Offset(2.0, 2.0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20.0,
                                ),
                                DropdownButtonFormField(
                                  isDense: true,
                                  value: selectedSubscription == "" ? null : selectedSubscription,
                                  items: generalController.subscriptionList.value,
                                  onChanged: (val) {
                                    setState(() {
                                      selectedSubscription = "${val}";
                                    });
                                    generalController.setSelectedSubscription("${val}");
                                  },
                                  icon: const Icon(
                                    Icons.arrow_drop_down_circle,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    labelText: "Subscription Type",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0)),
                                    isDense: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    /*Padding(
                      padding: EdgeInsets.all(10),
                      child: ,
                    ),*/
                  ],
                ),
              ),
            )),
            Container(
              color: Colors.black87,
              child: ElevatedButton(
                child: Text("Continue"),
                onPressed: () {
                  if(selectedRoute == "" || selectedSubscription == ""){
                    Fluttertoast.showToast(
                      msg: "All fields are required",
                      textColor: Colors.white
                    );
                  }else{
                    generalController.calculateRoutePrice(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black87,
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
                  /*shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),*/
                ),

              ),
            )
          ],
        )),
      ),
    );
  }
}
