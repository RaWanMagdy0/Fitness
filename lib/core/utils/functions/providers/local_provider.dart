import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalProvider extends ChangeNotifier {
  String locale = "en";

  Future<void> changeLanguage(String langCode) async {
    locale = langCode;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("app_lang", langCode);
  }

  Future<void> loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locale = prefs.getString("app_lang") ?? "en";
    notifyListeners();
  }
  LocalProvider(){
    loadSavedLanguage();
  }
}
