import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:fitness_app/presentation/auth/sign_up/view/actvity_screen.dart';
import 'package:flutter/material.dart';
import '../../presentation/auth/login/view/login_screen.dart' show LoginScreen;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/auth/sign_up/view/gender_screen.dart';
import '../../presentation/auth/sign_up/view/goal_screen.dart';
import '../../presentation/auth/sign_up/view/main_sign_up_screen.dart';
import '../../presentation/auth/sign_up/view_model/sign_up_cubit.dart';
import '../di/di.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case PageRouteName.mainSignUp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: SignUpPage(),
          ),
        );
      case PageRouteName.genderSignUp:
        return _handleMaterialPageRoute(widget: GenderScreen());
      case PageRouteName.login:
        return _handleMaterialPageRoute(widget: LoginScreen());
      case PageRouteName.goalScreen:
        return _handleMaterialPageRoute(widget: GoalScreen());
      case PageRouteName.actvityScreen:
        return _handleMaterialPageRoute(widget: ActivityScreen());
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
