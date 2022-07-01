import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  SharedPreferences? prefs;
  String is_authenticated = 'is_authenticated';
  SharedPreferencesService() {
    initiatePrefs();
    //  prefs = await SharedPreferences.getInstance();
  }

  initiatePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  saveAuthValue(bool isAuthenticated) async {
    prefs = prefs ?? await SharedPreferences.getInstance();
    prefs?.setBool(is_authenticated, isAuthenticated);
  }

  Future<bool> retrieveAuthValue() async {
    prefs = prefs ?? await SharedPreferences.getInstance();
    bool? value = prefs?.getBool(is_authenticated);
    print(value);
    return value ?? false;
  }
}
