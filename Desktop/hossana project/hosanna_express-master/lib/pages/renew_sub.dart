import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hosanna_shuttle/controllers/general_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../all_widgets/Divider.dart';

class PaynowScreen extends StatefulWidget {
  final String priceCode;
  final String priceValue;
  const PaynowScreen({Key? key, required this.priceCode, required this.priceValue}) : super(key: key);

  @override
  State<PaynowScreen> createState() => _PaynowScreenState();
}

class _PaynowScreenState extends State<PaynowScreen> {

  final generalController = Get.find<GeneralController>();
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  var isPageLoadingWebview = true;
  final momoNumberController = TextEditingController();

  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          "Pay Now",
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: 250.0,
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
              SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  generalController.selectedRoute.value == null ? "" : generalController.selectedRoute.value!.rtName!.split('-')[0],
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
                                  generalController.selectedRoute.value == null ? "" : generalController.selectedRoute.value!.rtName!.split('-')[1],
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
                    /*Padding(
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
                    ),*/
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Amount",
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "GHS ${widget.priceValue}",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Euclid Circular B Bold'),
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
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text('Pay with mobile money?'),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        controller: momoNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Mobile Money Number',
                          // prefixIcon: Icon(Icons.person_add),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          isDense: true,
                        ),
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
                      height: 10.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: ElevatedButton(
                        child: Text("Proceed to Payment"),
                        onPressed: ()=> generalController.makePayment(context, momoNumberController.value.text.trim()),
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
            ],
          ),
        ),
      ),
    ));
  }


  showMomoInputDialog(){
    if(Get.isDialogOpen!){
      Get.back();
    }
    Get.dialog(
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Container(
              padding: const EdgeInsets.all(24),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Column(
                    children: [

                      Text(
                        'Payment Details',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Text(
                        'Enter mobile money number below',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),

                      const SizedBox(height: 24,),
                      TextFormField(
                        controller: momoNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Mobile Money Number',
                          // prefixIcon: Icon(Icons.person_add),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          isDense: true,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      ElevatedButton(
                        child: Text("Continue"),
                        onPressed: () {
                          if (momoNumberController.value.text.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Enter momo number to proceed",
                              backgroundColor: Colors.red[400],
                              textColor: Colors.white);
                          } else {
                            generalController.makePayment(context, momoNumberController.value.text.trim());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black87,
                          fixedSize: Size(400, 60),
                          textStyle: TextStyle(
                            fontSize: 20.0,
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
                      )

                    ],
                  )
                ],
              )
          ),
        )
    );

  }


}
