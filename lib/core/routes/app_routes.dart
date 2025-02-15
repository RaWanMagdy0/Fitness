import 'package:fitness_app/core/routes/page_route_name.dart';
import 'package:flutter/material.dart';
import '../../presentation/auth/login/view/login_screen.dart' show LoginScreen;
import '../../presentation/auth/sign_up/view/gender_screen.dart';
import '../../presentation/auth/sign_up/view/main_sign_up_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case PageRouteName.mainSignUp:
        return _handleMaterialPageRoute(widget: SignUpPage());
        case PageRouteName.genderSignUp:
        return _handleMaterialPageRoute(widget: GenderScreen());
      case PageRouteName.login:
        return _handleMaterialPageRoute(widget: LoginScreen());
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
