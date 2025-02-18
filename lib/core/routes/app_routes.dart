import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:flutter/material.dart';
import '../../presentation/auth/login/view/login_screen.dart' show LoginScreen;
import '../../presentation/auth/sign_up/view/gender_screen.dart';
import '../../presentation/auth/sign_up/view/main_sign_up_screen.dart';

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
      case PageRouteName.login:
        return _handleMaterialPageRoute(widget: LoginScreen());
      case PageRouteName.mainSignUp:
        return _handleMaterialPageRoute(widget: SignUpPage());
      case PageRouteName.genderSignUp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: SignUpPage(),
          ),
        );
      case PageRouteName.genderSignUp:
        return _handleMaterialPageRoute(widget: GenderScreen());
      case PageRouteName.forgotPassword:
        return _handleMaterialPageRoute(
          widget: BlocProvider(
            create: (context) => getIt<ForgotPasswordCubit>(),
            child: ForgotPasswordScreen(),
          ),
        );
      case PageRouteName.verifyCode:
        return _handleMaterialPageRoute(widget: VerifyCodeScreen());
      case PageRouteName.resetPassword:
        return _handleMaterialPageRoute(widget: ResetPasswordScreen());

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
        return _handleMaterialPageRoute(
          widget: const Scaffold(
            body: Center(child: Text('No route defined')),
          ),
        );
    }
  }

  static MaterialPageRoute<dynamic> _handleMaterialPageRoute({
    required Widget widget,
  }) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
