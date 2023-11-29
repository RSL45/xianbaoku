import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static late SharedPreferences _preferences;

  static init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  //设置本地缓存
  static Future<bool> set<T>(String key, T value) {
    String type = value.runtimeType.toString();
    switch (type) {
      case "String":
        return _preferences.setString(key, value as String);
      case "int":
        return _preferences.setInt(key, value as int);
      case "bool":
        return _preferences.setBool(key, value as bool);
      case "double":
        return _preferences.setDouble(key, value as double);
      case "List<String>":
        return _preferences.setStringList(key, value as List<String>);
      case "_InternalLinkedHashMap<String,String>":
        return _preferences.setString(key, json.encode(value));
      default:
        return Future.value(false);
    }
  }

  //获取本地缓存
  static Object? get(String key) {
    Object? value = _preferences.get(key);
    if (value.runtimeType.toString() == "String") {
      try {
        return json.decode(value as String);
      } catch (error) {
        return value;
      }
    }
  }

  //删除缓存
  static Future<bool> remove(String key) {
    return _preferences.remove(key);
  }
}
