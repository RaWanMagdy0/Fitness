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
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    final stayLoggedIn = await SecureStorageFactory.readData(key: 'stay_logged_in') ?? 'false';
    log('SplashScreen stayLoggedIn: $stayLoggedIn', name: 'SplashScreen');

    if (stayLoggedIn == 'true') {
      Navigator.pushReplacementNamed(context, PageRouteName.layoutScreen);
    } else {
      final firstLaunch = await SecureStorageFactory.readData(key: 'first_launch') ?? 'true';

      if (firstLaunch == 'true') {
        await SecureStorageFactory.writeData(key: 'first_launch', value: 'false');
        Navigator.pushReplacementNamed(context, PageRouteName.onBoarding);
      } else {
        await TokenManager.deleteToken();
        Navigator.pushReplacementNamed(context, PageRouteName.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.splash2,
          fit: BoxFit.cover,
          width: double.infinity,
         // height: double.infinity,
        ),
      ),
    );
  }
}