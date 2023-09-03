import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {
  const LocalCache();
  void saveLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('language', language);
  }

  Future<String> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectedLanguageCode = prefs.getString('language') ?? 'en';
    return selectedLanguageCode;
  }
}
