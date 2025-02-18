import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:flutter/cupertino.dart';

import '../../core/styles/images/app_images.dart';
import 'custom_onboarding.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomOnboarding(
      position: 0,
      iconPath: AppImages.icon1png,
      mainText: "Fitness has never been so much fun",
      subText: "Stay active, stay strong, and enjoy the journey!",
      next: () => Navigator.pushReplacementNamed(context, PageRouteName.onBoarding2),
      skip: () => Navigator.pushReplacementNamed(context, PageRouteName.login),
      showBack: false,
    );
  }
}