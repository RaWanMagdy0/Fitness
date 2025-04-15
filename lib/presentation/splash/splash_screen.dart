import 'dart:developer';

import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/core/styles/images/app_images.dart';
import 'package:flutter/material.dart';
import '../../core/local/secure_storage.dart';
import '../../core/local/token_manger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginStatus();
    });
  }

  Future<void> _checkLoginStatus() async {
    final stayLoggedIn =
        await SecureStorageFactory.readData(key: 'stay_logged_in') ?? 'false';
    log(stayLoggedIn, name: 'SplashScreen stayLoggedIn');

    String route = PageRouteName.login;
    if (stayLoggedIn == 'true') {
      route = PageRouteName.layoutScreen;
    } else {
      TokenManager.deleteToken();
    }

    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Image.asset(
          AppImages.splash2,
        )
      ],
    ));
  }
}
