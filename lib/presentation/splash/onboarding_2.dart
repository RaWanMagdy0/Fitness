import 'package:flutter/cupertino.dart';

import '../../core/routes/page_route_name.dart';
import '../../core/styles/images/app_images.dart';
import 'custom_onboarding.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomOnboarding(
      position: 1,
      iconPath: AppImages.icon2png,
      mainText: "The Price Of Excellence Is Discipline",
      subText: "Success comes with dedication—stay focused!",
      next: () => Navigator.pushReplacementNamed(context, PageRouteName.onBoarding3),
      back: () => Navigator.pushReplacementNamed(context, PageRouteName.onBoarding1),
      skip: () => Navigator.pushReplacementNamed(context, PageRouteName.login),
    );
  }
}

