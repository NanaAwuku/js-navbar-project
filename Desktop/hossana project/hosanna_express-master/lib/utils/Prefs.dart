
import 'package:shared_preferences/shared_preferences.dart';

class Prefs{

  static setString(String key,String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String> getString(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key)!;
  }

  static setBoolean(String key,bool value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool> getBoolean(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(key) ?? false;
  }

  static clearPreferences() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

}