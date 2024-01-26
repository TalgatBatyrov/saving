import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {
  const LocalCache();
  void saveTranslate(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
  }

  Future<String?> getTranslate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final language = prefs.getString('language');
    return language;
  }
}
