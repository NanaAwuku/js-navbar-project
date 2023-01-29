import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

const BASE_URL = 'https://hosannaexpress.com/shuttleapi/';
const END_POINT = 'api.php';
const API_KEY =
    '38725045534b6366415a3074354a7a645437626c57516f4e7579776d583344366831596a787356673246486b494c39697134614f65764d6e525543477042';

class HttpService {
  Dio? _dio;

  void init() {
    _dio = Dio(BaseOptions(
        baseUrl: BASE_URL,
        validateStatus: (_) => true,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'}));

    initializeInterceptors();
  }

  initializeInterceptors() {
    _dio!.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print(options.uri);
      //print(options.headers);
      // Do something before request is sent
      return handler.next(options); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onResponse: (response, handler) {
      //print(response.data);
      // Do something with response data
      return handler.next(response); // continue
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: `handler.reject(dioError)`
    }, onError: (DioError e, handler) {
      print(e.message);
      // Do something with response error
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: `handler.resolve(response)`.
    }));
  }

  Future<Response?> login(String phone, String password) async {
    try {
      return await _dio!.get(END_POINT, queryParameters: {
        'apikey': API_KEY,
        'actions': 'login',
        'phoneno': phone,
        'pwd': password
      });
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> register(String firstName, String lastName, String dob,
      String gender, String phone, String email) async {
    try {
      return await _dio!.get(END_POINT, queryParameters: {
        'apikey': API_KEY,
        'actions': 'registeruser',
        'fname': firstName,
        'lname': lastName,
        'dob': dob,
        'gender': gender,
        'phoneno': phone,
        'email': email,
      });
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> sendOtp(String phone) async {
    try {
      return await _dio!.get(END_POINT, queryParameters: {
        'apikey': API_KEY,
        'actions': 'forgottenpassword',
        'phoneno': phone
      });
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> verifyOtp(String phone, String otp, String password) async {
    try {
      return await _dio!.get(END_POINT, queryParameters: {
        'apikey': API_KEY,
        'actions': 'verifyphoneno',
        'phoneno': phone,
        'otp': otp,
        'pwd': password
      });
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /* Subscriptions */
  Future<Response?> getRoutes() async {
    try {
      return await _dio!.get(END_POINT, queryParameters: {
        'apikey': API_KEY,
        'actions': 'getroutes',
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> getBusStops() async {
    try {
      return await _dio!.get(END_POINT,
          queryParameters: {'apikey': API_KEY, 'actions': 'getbusstops'});
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> getSubscriptions() async {
    try {
      return await _dio!.get(END_POINT, queryParameters: {
        'apikey': API_KEY,
        'actions': 'getsubscriptions',
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Response?> calculateRoutePrice(
      String routeCode, String subscriptionCode) async {
    try {
      return await _dio!.get(END_POINT, queryParameters: {
        'apikey': API_KEY,
        'actions': 'getroutesubscriptions',
        'route_code': routeCode,
        'bill_code': subscriptionCode
      });
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      print(e);
      return null;
    }
  }
  Future<Response?> makePayment(String clientId, String route, String subscription, String momonumber) async {
    try {
      return await _dio!.get(
          END_POINT,
          queryParameters: {
            'apikey': '38725045534b6366415a3074354a7a645437626c57516f4e7579776d583344366831596a787356673246486b494c39697134614f65764d6e525543477042',
            'actions': 'payment',
            'clientid': clientId,
            'route': route,
            'subscription': subscription,
            'momonum': momonumber,
          }
      );
    } catch (e) {
      print(e);
      return null;
    }

  }

  Future<Response?> getDepartureTime(String route) async {
    try {
      return await _dio!.get(END_POINT,
          queryParameters: {
            'apikey': API_KEY, 
          'actions': 'getdeparturetime',
          'route': route
          });
    } catch (e) {
      print(e);
      return null;
    }
  }


  Future<Response?> checkIn(String clientId, String route, String departure, String busStop) async {
    try {
      return await _dio!.get(END_POINT, queryParameters: {
        'apikey': API_KEY,
        'actions': 'checkin',
        'clientid': clientId,
        'route': route,
        'departureid': departure,
        'pickuplocation': busStop
      });
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      print(e);
      return null;
    }
  }

    Future<Response?> getUserDetails(
      String clientId, String route, String departure, String busStop) async {
    try {
      return await _dio!.get(END_POINT, queryParameters: {
        'apikey': API_KEY,
        'actions': 'checkin',
        'otp': clientId,
        'otp': route,
        'otp': departure,
        'otp': busStop
      });
    } on DioError catch (e) {
      return e.response;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
