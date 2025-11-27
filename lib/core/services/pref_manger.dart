import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  static final PrefManager _instance = PrefManager._internal();

  PrefManager._internal();

  factory PrefManager() {
    return _instance;
  }

  late final SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> setString(String key, String value) {
    return _prefs.setString(key,value);
  }
  Future<bool> setBool(String key, bool value) {
    return _prefs.setBool(key,value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }
  void remove(String key) {
    _prefs.remove(key);
  }
}
