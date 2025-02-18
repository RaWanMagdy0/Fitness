import 'package:flutter/material.dart';

import '../../core/routes/page_route_name.dart';
import '../../core/styles/images/app_images.dart';
import 'custom_onboarding.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      // انتقل إلى صفحة تسجيل الدخول بعد آخر صفحة Onboarding
      Navigator.pushReplacementNamed(context, PageRouteName.login);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        children: [
          CustomOnboarding(
            iconPath: AppImages.icon1png,
            mainText: "Fitness has never been so much fun",
            subText: "Stay active, stay strong, and enjoy the journey!",
            onNext: _nextPage,
            showBack: false,
          ),
          CustomOnboarding(
            iconPath: AppImages.icon2png,
            mainText: "The Price Of Excellence Is Discipline",
            subText: "Success comes with dedication—stay focused!",
            onNext: _nextPage,
            onBack: _previousPage,
          ),
          CustomOnboarding(
            iconPath: AppImages.icon3png,
            mainText: "NO MORE EXCUSES\nDo It Now",
            subText: "The best time to start is NOW! Take action!",
            onNext: _nextPage,
            onBack: _previousPage,
            isLast: true,
          ),
        ],
      ),
    );
  }
}
