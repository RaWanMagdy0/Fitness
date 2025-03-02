import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppProvider extends ChangeNotifier {
  String _email = "";

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  set token(String value) {
    notifyListeners();
  }
}
