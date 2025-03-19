import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/presentation/home/home_screen/view_model/home_cubit.dart';
import 'package:fitness_app/presentation/profile/view/main_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/auth/forgot_password/cubit/forgot_password_cubit.dart';
import '../../presentation/auth/forgot_password/view/forgot_password_screen.dart';
import '../../presentation/auth/forgot_password/view/reset_password_screen.dart';
import '../../presentation/auth/forgot_password/view/verify_code_screen.dart';
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
import '../../presentation/edit_profile/view/edit_profile_screen.dart'
    show EditProfileScreen;
import '../../presentation/home/exercise_screen/view/exercise_screen.dart';
import '../../presentation/home/exercise_screen/view_model/exercise_view_model.dart';
import '../../presentation/home/home_screen/view/home_screen.dart';
import '../../presentation/home/workout/view/workout_screen.dart';
import '../../presentation/home/workout/view_model/workout_cubit.dart';
import '../../presentation/layout/main_page.dart';
import '../../presentation/edit_profile/view_model/edit_profile_cubit.dart'
    show EditProfileCubit;
import '../../presentation/meal/view/meal_details_screen.dart'
    show MealDetailsScreen;
import '../../presentation/meal/view/meals_screen.dart';
import '../../presentation/meal/view_model/meal_details_cubit.dart'
    show MealDetailsCubit;
import '../../presentation/layout/main_page.dart';
import '../../presentation/edit_profile/view_model/edit_profile_cubit.dart';
import '../../presentation/meal/view/meal_details_screen.dart';
import '../../presentation/meal/view_model/meal_details_cubit.dart';
import '../../presentation/online_coach/view/chat_screen.dart';
import '../../presentation/online_coach/view/robot_screen.dart';
import '../../presentation/online_coach/view_model/smart_coach_cubit.dart';
import '../../presentation/profile/view_model/profile_cubit.dart';
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
      case PageRouteName.chatScreen:
        final chatTitle = setting.arguments as String?;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<GeminiCubit>(),
            child: ChatScreen(title: chatTitle),
          ),
        );

      case PageRouteName.weightScreen:
      // Handle differently if coming from edit profile vs signup flow
        return MaterialPageRoute(
          settings: setting,
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: WeightScreen(),
          ),
        );

      case PageRouteName.heightScreen:
        return MaterialPageRoute(
          settings: setting,
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: HeightScreen(),
          ),
        );

      case PageRouteName.ageScreen:
        return MaterialPageRoute(
          settings: setting,
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
      case PageRouteName.mealDetailsScreen:
        final args = setting.arguments as Map<String, dynamic>;
        final String mealId = args['mealId'];
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<MealDetailsCubit>(),
            child: MealDetailsScreen(mealId: mealId),
          ),
        );
      case PageRouteName.exerciseScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ExerciseViewModel>(),
            child: ExerciseScreen(),
          ),
        );
      case PageRouteName.homeScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<HomeCubit>(),
            child: HomeScreen(),
          ),
        );

      case PageRouteName.onBoarding:
        return _handleMaterialPageRoute(widget: OnboardingScreen());
      case PageRouteName.robotScreen:
        return _handleMaterialPageRoute(widget: RobotScreen());
      case PageRouteName.mainProfileScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ProfileCubit>(),
            child: MainProfileScreen(),
          ),
        );

      case PageRouteName.editProfileScreen:
        return MaterialPageRoute(
          settings: setting,
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => getIt<EditProfileCubit>()),
              BlocProvider.value(value: getIt<ProfileCubit>()),
            ],
            child: EditProfileScreen(),
          ),
        );

      case PageRouteName.layoutScreen:
        return _handleMaterialPageRoute(widget: const MainPage());


      case PageRouteName.mealsScreen:
        return _handleMaterialPageRoute(widget: MealsScreen());
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
