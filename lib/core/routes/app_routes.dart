import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/presentation/auth/login/view_model/login_cubit.dart';
import 'package:fitness_app/presentation/auth/sign_up/view/actvity_screen.dart';
import 'package:fitness_app/presentation/auth/sign_up/view/age_screen.dart';
import 'package:fitness_app/presentation/auth/sign_up/view/height_screen.dart';
import 'package:flutter/material.dart';
import '../../presentation/auth/home/view/home_screen.dart';
import '../../presentation/auth/login/view/login_screen.dart' show LoginScreen;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/auth/sign_up/view/gender_screen.dart';
import '../../presentation/auth/sign_up/view/goal_screen.dart';
import '../../presentation/auth/sign_up/view/main_sign_up_screen.dart';
import '../../presentation/auth/sign_up/view/weight_screen.dart';
import '../../presentation/auth/sign_up/view_model/sign_up_cubit.dart';
import '../../presentation/splash/onboarding_1.dart';
import '../../presentation/splash/onboarding_2.dart';
import '../../presentation/splash/onboarding_3.dart';
import '../../presentation/splash/splash_screen.dart';
import '../di/di.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {

      case PageRouteName.splashscreen:
        return _handleMaterialPageRoute(widget: SplashScreen());
      case PageRouteName.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: LoginScreen(),
          ),
        );
      case PageRouteName.mainSignUp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: SignUpPage(),
          ),
        );
      case PageRouteName.genderSignUp:
        return _handleMaterialPageRoute(widget: GenderScreen());

      case PageRouteName.weightScreen:
        return _handleMaterialPageRoute(widget: WeightScreen());
      case PageRouteName.heightScreen:
        return _handleMaterialPageRoute(widget: HeightScreen());
      case PageRouteName.ageScreen:
        return _handleMaterialPageRoute(widget: AgeScreen());
      case PageRouteName.goalScreen:
        return _handleMaterialPageRoute(widget: GoalScreen());
        case PageRouteName.onBoarding1:
        return _handleMaterialPageRoute(widget: Onboarding1());
        case PageRouteName.onBoarding2:
        return _handleMaterialPageRoute(widget: Onboarding2());
        case PageRouteName.onBoarding3:
        return _handleMaterialPageRoute(widget: Onboarding3());
      case PageRouteName.activityScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: ActivityScreen(),
          ),
        );
      case PageRouteName.homeScreen:
        return _handleMaterialPageRoute(widget: HomeScreen());
      default:
        return _handleMaterialPageRoute(widget: const Scaffold());
    }
  }

  static MaterialPageRoute<dynamic> _handleMaterialPageRoute({
    required Widget widget,
  }) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
