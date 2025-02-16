import 'package:fitness_app/core/local/secure_storage_helper.dart';
import 'package:flutter/material.dart';

class SignupProvider extends ChangeNotifier {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? gender;
  int? height;
  int? weight;
  int? age;
  String? goal;
  String? activityLevel;

  SignupProvider() {
    loadUserData();
  }

  Future<void> loadUserData() async {
    firstName = await SecureStorageHelper.getData('firstName');
    lastName = await SecureStorageHelper.getData('lastName');
    email = await SecureStorageHelper.getData('email');
    password = await SecureStorageHelper.getData('password');
    gender = await SecureStorageHelper.getData('gender');
    height = _parseInt(await SecureStorageHelper.getData('height'));
    weight = _parseInt(await SecureStorageHelper.getData('weight'));
    age = _parseInt(await SecureStorageHelper.getData('age'));
    goal = await SecureStorageHelper.getData('goal');
    activityLevel = await SecureStorageHelper.getData('activityLevel');

    notifyListeners();
  }

  Future<void> saveData(String key, String value) async {
    await SecureStorageHelper.saveData(key, value);

    switch (key) {
      case 'firstName':
        firstName = value;
        break;
      case 'lastName':
        lastName = value;
        break;
      case 'email':
        email = value;
        break;
      case 'password':
        password = value;
        break;
      case 'gender':
        gender = value;
        break;
      case 'height':
        height = _parseInt(value);
        break;
      case 'weight':
        weight = _parseInt(value);
        break;
      case 'age':
        age = _parseInt(value);
        break;
      case 'goal':
        goal = value;
        break;
      case 'activityLevel':
        activityLevel = value;
        break;
    }

    notifyListeners();
  }

  String? getData(String key) {
    switch (key) {
      case 'firstName':
        return firstName;
      case 'lastName':
        return lastName;
      case 'email':
        return email;
      case 'password':
        return password;
      case 'gender':
        return gender;
      case 'height':
        return height?.toString();
      case 'weight':
        return weight?.toString();
      case 'age':
        return age?.toString();
      case 'goal':
        return goal;
      case 'activityLevel':
        return activityLevel;
      default:
        return null;
    }
  }

  Future<void> clearUserData() async {
    await SecureStorageHelper.clearData();
    firstName =
        lastName = email = password = gender = goal = activityLevel = null;
    height = weight = age = null;

    notifyListeners();
  }

  int? _parseInt(String? value) {
    return value != null && value.isNotEmpty ? int.tryParse(value) : null;
  }
}
