import 'package:http/http.dart' as http;
import 'dart:convert';

Future<User> fetchUser() async {
  final response = await http
      .get(Uri.parse('https://hosannaexpress.com/shuttleapi/api.php'), headers: {'apikey': '38725045534b6366415a3074354a7a645437626c57516f4e7579776d583344366831596a787356673246486b494c39697134614f65764d6e525543477042', 'actions': 'login', 'phoneno':"020987123", 'pwd':"space123"});

  if (response.statusCode == 200) {
    // var jsonData =  User.fromJson(jsonDecode(response.body));
    print(response);
    
     return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

class User {
  final int phoneno;
  final String pwd;

  const User({
    required this.phoneno,
    required this.pwd,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      phoneno: json['phoneNumber'],
      pwd: json['password'],
    );
  }
}

