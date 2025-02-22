import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/presentation/profile/view/main_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/auth/forgot_password/cubit/forgot_password_cubit.dart';
import '../../presentation/auth/forgot_password/view/forgot_password_screen.dart';
import '../../presentation/auth/forgot_password/view/reset_password_screen.dart';
import '../../presentation/auth/forgot_password/view/verify_code_screen.dart';
import '../../presentation/auth/home/view/home_screen.dart';
import '../../presentation/auth/login/view/login_screen.dart' show LoginScreen;
import '../../presentation/auth/login/view_model/login_cubit.dart';
import '../../presentation/auth/sign_up/view/actvity_screen.dart';
import '../../presentation/auth/sign_up/view/age_screen.dart';
import '../../presentation/auth/sign_up/view/gender_screen.dart';
import '../../presentation/auth/sign_up/view/goal_screen.dart';
import '../../presentation/auth/sign_up/view/height_screen.dart';
import '../../presentation/auth/sign_up/view/main_sign_up_screen.dart';
import '../../presentation/auth/sign_up/view/weight_screen.dart';
import '../../presentation/auth/sign_up/view_model/sign_up_cubit.dart';
import '../../presentation/edit_profile/view/edit_profile_screen.dart' show EditProfileScreen;
import '../../presentation/splash/onboarding.dart';
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
      case PageRouteName.genderSignUp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: GenderScreen(),
          ),
        );
      case PageRouteName.mainSignUp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: getIt<SignUpCubit>(),
            child: SignUpPage(),
          ),
        );
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
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: WeightScreen(),
          ),
        );
      case PageRouteName.heightScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: HeightScreen(),
          ),
        );
      case PageRouteName.ageScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: AgeScreen(),
          ),
        );
      case PageRouteName.goalScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: GoalScreen(),
          ),
        );
      case PageRouteName.activityScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: ActivityScreen(),
          ),
        );
      case PageRouteName.onBoarding:
        return _handleMaterialPageRoute(widget: OnboardingScreen());
      case PageRouteName.homeScreen:
        return _handleMaterialPageRoute(widget: HomeScreen());
      case PageRouteName.mainProfileScreen:
        return _handleMaterialPageRoute(widget: MainProfileScreen());
      case PageRouteName.editProfileScreen: // Added this case
        return _handleMaterialPageRoute(widget: EditProfileScreen());
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