import 'package:flutter/cupertino.dart';

import '../../core/routes/page_route_name.dart';
import '../../core/styles/images/app_images.dart';
import 'custom_onboarding.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomOnboarding(
      position: 2,
      iconPath: AppImages.icon3png,
      mainText: "NO MORE EXCUSES\nDo It Now",
      subText: "The best time to start is NOW! Take action!",
      next: () => Navigator.pushReplacementNamed(context, PageRouteName.login),
      back: () => Navigator.pushReplacementNamed(context, PageRouteName.onBoarding2),
      skip: () => Navigator.pushReplacementNamed(context, PageRouteName.login),
    );
  }
}
