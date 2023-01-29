import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart' as dio;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hosanna_shuttle/all_Screens/loginScreen.dart';
import 'package:hosanna_shuttle/all_screens/mainscreen.dart';
import 'package:hosanna_shuttle/all_screens/nonSub_screen.dart';
import 'package:hosanna_shuttle/pages/route.dart';
import 'package:hosanna_shuttle/pages/verification.dart';
import 'package:hosanna_shuttle/service/models/bus_stop.dart';
import 'package:hosanna_shuttle/service/models/pickup_route.dart';
import 'package:hosanna_shuttle/service/models/subscription.dart';
import 'package:hosanna_shuttle/service/models/departure.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../pages/checkout_screen.dart';
import '../pages/paynow.dart';
import '../service/network/http_service.dart';
import '../utils/Prefs.dart';
import '../utils/Utils.dart';
import '../utils/constants.dart';

class GeneralController extends GetxController {
  final HttpService _httpService = HttpService();

  SharedPreferences? prefs;
  //Rx<UserProfile?> userProfile = Rx(null);

  init() async {
    //await NotificationService().init();
    prefs = await SharedPreferences.getInstance();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult results) {
      if (results == ConnectivityResult.none) {
      } else {}
    });
  }

  Future<bool> isConnectedToInternet() async {
    final Connectivity _connectivity = Connectivity();
    ConnectivityResult connectivityResult =
        await _connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  splashScreenTimeout() async {
    final hasLogged = await Prefs.getBoolean(kIsLoggedIn);
    final routeStatus = await Prefs.getBoolean(kRouteStatus);
    final _timer = Timer(const Duration(seconds: 3), () {
      if (hasLogged) {
        if (routeStatus) {
          Get.offAll(MainScreen());
        } else {
          Get.offAll(MainScreen());
        }
      } else {
        Get.offAll(LoginScreen());
      }
    });
  }

  /* Auth */
  var shouldHidePassword = true.obs;
  var isAwaitingOtp = true.obs;
  var canResendOtp = false.obs;
  login(BuildContext context, String username, String password) async {
    Utils.showProgressDialog(context);
    final navigator = Navigator.of(context);

    _httpService.init();
    final response = await _httpService.login(username, password);

    if (response == null) {
      navigator.pop();
      Fluttertoast.showToast(
          msg: "Unable to process request, retry",
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
    } else {
      navigator.pop();

      if (response.data['msg'] == 'success') {
        final firstName = response.data['data']['fname'];
        final lastName = response.data['data']['lname'];
        final phoneName = response.data['data']['phoneno'];
        final clientID = response.data['data']['clientid'];
        final routeStatus = response.data['data']['route_status'];
        final routeCode = response.data['data']['route'];
        final hasActiveSub = response.data['data']['hasactivesubscription'];

        Prefs.setBoolean(kIsLoggedIn, true);
        Prefs.setString(kUserDetails, json.encode(response.data['data']));
        Prefs.setString(kUserFirstName, firstName);
        Prefs.setString(kUserLastName, lastName);
        Prefs.setString(kUserPhoneNumber, phoneName);
        Prefs.setString(kUserClientId, clientID);
        Prefs.setBoolean(kRouteStatus, routeStatus);
        Prefs.setString(kRouteCode, routeCode);
        Prefs.setBoolean(kHasActiveSubscription, hasActiveSub);

        Fluttertoast.showToast(
            msg: 'Welcome $firstName',
            backgroundColor: Colors.green[400],
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
            textColor: Colors.white);

        if (routeStatus) {
          Get.offAll(() => const MainScreen());
        } else {
          Get.offAll(() => const MainScreen());
        }

        // Get.offAll(() => const MainScreen());
      } else if (response.data['msg'] == 'error') {
        Fluttertoast.showToast(
            msg: response.data['data'],
            backgroundColor: Colors.red[400],
            textColor: Colors.white);
      } else {
        Fluttertoast.showToast(
            msg: "User login failed, try again later.",
            backgroundColor: Colors.red[400],
            textColor: Colors.white);
      }
    }
  }

  register(BuildContext context, String firstName, String lastName, String dob,
      String gender, String phone, String email) async {
    Utils.showProgressDialog(context);
    final navigator = Navigator.of(context);

    _httpService.init();
    final response = await _httpService.register(
        firstName, lastName, dob, gender, phone, email);

    if (response == null) {
      navigator.pop();
      Fluttertoast.showToast(
          msg: "Unable to process request, retry",
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
    } else {
      navigator.pop();

      if (response.data['msg'] == 'success') {
        Fluttertoast.showToast(
            msg: "Account created, please login",
            backgroundColor: Colors.green[400],
            textColor: Colors.white);

        Get.offAll(() => const LoginScreen());
      } else if (response.data['msg'] == 'error') {
        Fluttertoast.showToast(
            msg: response.data['data'],
            backgroundColor: Colors.red[400],
            textColor: Colors.white);
      } else {
        Fluttertoast.showToast(
            msg: "Account creation failed, try again later",
            backgroundColor: Colors.red[400],
            textColor: Colors.white);
      }
    }
  }

  sendOtp(BuildContext context, String phone) async {
    Utils.showProgressDialog(context);
    final navigator = Navigator.of(context);

    _httpService.init();
    final response = await _httpService.sendOtp(phone);

    if (response == null) {
      navigator.pop();
      Fluttertoast.showToast(
          msg: "Unable to process request, retry",
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
    } else {
      navigator.pop();

      if (response.data['msg'] == 'success') {
        Fluttertoast.showToast(
            msg: response.data['data'],
            backgroundColor: Colors.green[400],
            textColor: Colors.white);

        Get.to(() => Verification(
              phoneNumber: phone,
            ));
      } else {
        Fluttertoast.showToast(
            msg: "Unable to send verification code",
            backgroundColor: Colors.red[400],
            textColor: Colors.white);
      }
    }
  }

  verifyOtp(
      BuildContext context, String phone, String password, String otp) async {
    Utils.showProgressDialog(context);
    final navigator = Navigator.of(context);

    _httpService.init();
    final response = await _httpService.verifyOtp(phone, otp, password);

    if (response == null) {
      navigator.pop();
      Fluttertoast.showToast(
          msg: "Unable to process request, retry",
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
    } else {
      navigator.pop();

      //print(response.data);

      if (response.data['msg'] == 'success') {
        Fluttertoast.showToast(
            msg: "Password reset successful, login",
            backgroundColor: Colors.green[400],
            textColor: Colors.white);

        Get.offAll(() => LoginScreen());
      } else {
        Fluttertoast.showToast(
            msg: "Password reset failed, try again",
            backgroundColor: Colors.red[400],
            textColor: Colors.white);
      }
    }
  }

  getUserProfile() async {
    /*final profile = await Prefs.getString(kProfile);
    if (profile != '') {
      //print(profile);
      userProfile.value = userProfileFromJson(profile);
      userProfile.refresh();
    }
    final isConnected = await isConnectedToInternet();
    if (isConnected) {
      await _httpService.init();
      final response = await _httpService.getUserProfile();
      if (response != null) {
        //print(response.data);
        await Prefs.setString(kToken, response.data['token']);
        if (response.data['status']) {
          userProfile.value = userProfileFromJson(jsonEncode(response.data['data']));
          userProfile.refresh();
          Prefs.setString(kProfile, jsonEncode(response.data['data']));
          if (userProfile.value?.login.status != '1') {
            showAccountDeactivatedDialog();
          }
        }else{
          if (response.data['code'] == 401) {
            showSessionExpiryDialog();
          }else{
            */ /*Fluttertoast.showToast(
                msg: response.data['msg'],
                backgroundColor: Colors.red[400],
                textColor: Colors.white
            );*/ /*
          }
        }
      }
    }*/
  }

  //Utils
  var routesList = <DropdownMenuItem<String>>[].obs;
  var busStopList = <DropdownMenuItem<String>>[].obs;
  var subscriptionList = <DropdownMenuItem<String>>[].obs;
  var departureList = <DropdownMenuItem<String>>[].obs;
  Rx<PickUpRoute?> selectedRoute = Rx(null);
  Rx<BusStop?> selectedBusStop = Rx(null);
  Rx<Subscription?> selectedSubscription = Rx(null);
  Rx<Departure?> selectedDepartureBusTime = Rx(null);
  getRoutes() async {
    _httpService.init();
    final response = await _httpService.getRoutes();

    if (response != null) {
      //print(response.data);
      if (response.data['msg'] == 'success') {
        Prefs.setString(kRoutes, jsonEncode(response.data['data']));
        loadRoutes();
      }
    }
  }

  loadRoutes() async {
    final routesJson = await Prefs.getString(kRoutes);
    if (routesJson != '') {
      final routes = routesFromJson(routesJson);
      routesList.value.clear();
      routes.forEach((element) {
        routesList.value.add(DropdownMenuItem(
          child: Text(element.rtName!),
          value: element.rtCode,
        ));
      });
      routesList.refresh();
    }
  }

  setSelectedRoute(String code) async {
    final routeJson = await Prefs.getString(kRoutes);
    if (routeJson != '') {
      final routes = routesFromJson(routeJson);
      routes.where((element) => element.rtCode == code).forEach((element) {
        selectedRoute.value = element;
        print(selectedRoute.value!.rtMaplink);
      });
    }
  }

  getSelectedRoute(String code) async {
    final routeJson = await Prefs.getString(kRoutes);
    if (routeJson != '') {
      final routes = routesFromJson(routeJson);
      routes.where((element) => element.rtCode == code).forEach((element) {
        selectedRoute.value = element;
      });
    }
    return selectedRoute.value;
  }

  getBusStops() async {
    _httpService.init();
    final response = await _httpService.getBusStops();

    if (response != null) {
      //print(response.data);
      if (response.data['msg'] == 'success') {
        Prefs.setString(kBusStop, jsonEncode(response.data['data']));
      }
    }
  }

  loadBusStops(String route) async {
    final busStopJson = await Prefs.getString(kBusStop);
    if (busStopJson != '') {
      final busStops = busStopFromJson(busStopJson);
      busStopList.value.clear();
      busStops
          .where((element) => element.rtbRtcode == route)
          .forEach((element) {
        busStopList.value.add(DropdownMenuItem(
          child: Text(element.rtbName!),
          value: element.rtbCode,
        ));
      });
      busStopList.refresh();
    }
  }

  setSelectedBusStop(String code) async {
    final busStopJson = await Prefs.getString(kBusStop);
    if (busStopJson != '') {
      final busStops = busStopFromJson(busStopJson);
      busStops.where((element) => element.rtbCode == code).forEach((element) {
        selectedBusStop.value = element;
      });
    }
  }

  getSubscriptions() async {
    _httpService.init();
    final response = await _httpService.getSubscriptions();

    if (response != null) {
      //print(response.data);
      if (response.data['msg'] == 'success') {
        Prefs.setString(kSubscription, jsonEncode(response.data['data']));
        loadSubscriptions();
      }
    }
  }

  loadSubscriptions() async {
    final subscriptionJson = await Prefs.getString(kSubscription);
    if (subscriptionJson != '') {
      final subscriptions = subscriptionFromJson(subscriptionJson);
      subscriptionList.value.clear();
      subscriptions.forEach((element) {
        subscriptionList.value.add(DropdownMenuItem(
          child: Text(element.blName),
          value: element.blCode,
        ));
      });
      subscriptionList.refresh();
    }
  }

  setSelectedSubscription(String code) async {
    final subscriptionJson = await Prefs.getString(kSubscription);
    if (subscriptionJson != '') {
      final subscriptions = subscriptionFromJson(subscriptionJson);
      subscriptions
          .where((element) => element.blCode == code)
          .forEach((element) {
        selectedSubscription.value = element;
      });
    }
  }

  getDepartureTime(String route) async {
    _httpService.init();
    final response = await _httpService.getDepartureTime(route);

    if (response != null) {
      print(response.data);
      if (response.data['msg'] == 'success') {
        Prefs.setString(kDepartureBusTime, jsonEncode(response.data['data']));
        loadDepartureTime();
      }
    }
  }

  loadDepartureTime() async {
    final departureBusTimeJson = await Prefs.getString(kDepartureBusTime);
    if (departureBusTimeJson != '') {
      final departures = departureFromJson(departureBusTimeJson);
      departureList.value.clear();
      departures.forEach((element) {
        departureList.value.add(DropdownMenuItem(
          child: Text(element.time),
          value: element.code,
        ));
      });
      departureList.refresh();
    }
  }

  setSelectedDeparture(String code) async {
    final departureBusTimeJson = await Prefs.getString(kDepartureBusTime);
    if (departureBusTimeJson != '') {
      final subscriptions = departureFromJson(departureBusTimeJson);
      subscriptions.where((element) => element.code == code).forEach((element) {
        selectedDepartureBusTime.value = element;
      });
    }
  }

  calculateRoutePrice(BuildContext context) async {
    Utils.showProgressDialog(context);
    final navigator = Navigator.of(context);

    _httpService.init();
    final response = await _httpService.calculateRoutePrice(
        selectedRoute.value!.rtCode!, selectedSubscription.value!.blCode);

    if (response == null) {
      navigator.pop();
      Fluttertoast.showToast(
          msg: "Unable to process request, retry",
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
    } else {
      navigator.pop();

      print(response.data);

      if (response.data['msg'] == 'success') {
        Get.to(() => PaynowScreen(
              priceCode: response.data['data'][0]['PR_CODE'],
              priceValue: response.data['data'][0]['PR_AMOUNT'],
            ));
      } else if (response.data['msg'] == 'error') {
        Fluttertoast.showToast(
            msg: response.data['data'],
            backgroundColor: Colors.red[400],
            textColor: Colors.white);
      } else {
        Fluttertoast.showToast(
            msg: "Sorry, unable to get price details. Please retry",
            backgroundColor: Colors.red[400],
            textColor: Colors.white);
      }
    }
  }

  checkIn(BuildContext context) async {
    Utils.showProgressDialog(context);
    final navigator = Navigator.of(context);

    String clientId = await Prefs.getString(kUserClientId);

    if (clientId != '') {
      _httpService.init();
      final response = await _httpService.checkIn(
          clientId,
          selectedRoute.value!.rtCode,
          selectedBusStop.value!.rtbCode,
          selectedDepartureBusTime.value!.code);

      if (response == null) {
        navigator.pop();
        Fluttertoast.showToast(
            msg: "Unable to process request, retry",
            backgroundColor: Colors.red[400],
            textColor: Colors.white);
      } else {
        navigator.pop();

        print(response.data);

        if (response.data['msg'] == 'success') {
          Get.to(() => PaynowScreen(
                priceCode: response.data['data'][0]['PR_CODE'],
                priceValue: response.data['data'][0]['PR_AMOUNT'],
              ));
        } else if (response.data['msg'] == 'error') {
          Fluttertoast.showToast(
              msg: response.data['data'],
              backgroundColor: Colors.red[400],
              textColor: Colors.white);
        } else {
          Fluttertoast.showToast(
              msg: "Sorry, unable to get price details. Please retry",
              backgroundColor: Colors.red[400],
              textColor: Colors.white);
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: "Invalid User ID, ensure the user is logged in",
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
    }
  }

  makePayment(BuildContext context, String momoNumber) async {
    Utils.showProgressDialog(context);
    final navigator = Navigator.of(context);

    final clientId = await Prefs.getString(kUserClientId);

    _httpService.init();
    final response = await _httpService.makePayment(
        clientId,
        selectedRoute.value!.rtCode!,
        selectedSubscription.value!.blCode,
        momoNumber);

    if (response == null) {
      navigator.pop();
      Fluttertoast.showToast(
          msg: "Unable to process request, retry",
          backgroundColor: Colors.red[400],
          textColor: Colors.white);
    } else {
      navigator.pop();

      print(response.data);

      if (response.data['msg'] == 'success') {
        Fluttertoast.showToast(
            msg: response.data['data'],
            backgroundColor: Colors.green[400],
            textColor: Colors.white);

        Get.to(() => CheckoutScreen(
              url: response.data['checkoutUrl'],
            ));
      } else if (response.data['msg'] == 'error') {
        Fluttertoast.showToast(
            msg: response.data['data'],
            backgroundColor: Colors.red[400],
            textColor: Colors.white);
      } else {
        Fluttertoast.showToast(
            msg: "Sorry, unable to process payment, retry",
            backgroundColor: Colors.red[400],
            textColor: Colors.white);
      }
    }
  }

  /*getBusStops(BuildContext context, String routeCode) async{
    Utils.showProgressDialog(context);
    final navigator = Navigator.of(context);

    _httpService.init();
    final response = await _httpService.getRouteBusStops(routeCode);

    if(response == null) {
      navigator.pop();
      Fluttertoast.showToast(
          msg: "No routes mapped out yet! Try again later.",
          backgroundColor: Colors.red[400],
          textColor: Colors.white
      );
    }else{

      navigator.pop();

      print(response.data);

      if(response.data['msg'] == 'success'){

        var busStops = busStopFromJson(jsonEncode(response.data['data']));
        busStopList.value.clear();

        if(busStops.isNotEmpty){
          busStops.forEach((element) {
            //print(element.rtName);
            busStopList.value.add(DropdownMenuItem(
              child: Text(element.rtbName!),
              value: element.rtbCode!,
            ));
          });
          busStopList.refresh();
        }

      }else{

        Fluttertoast.showToast(
            msg: response.data['data'],
            backgroundColor: Colors.red[400],
            textColor: Colors.white
        );

      }

    }
  }*/

}
