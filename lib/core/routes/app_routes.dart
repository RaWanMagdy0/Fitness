import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../di/di.dart';
import '../routes/page_route_name.dart';
import '../../presentation/auth/login/view/login_screen.dart';
import '../../presentation/auth/sign_up/view/main_sign_up_screen.dart';
import '../../presentation/auth/sign_up/view/gender_screen.dart';
import '../../presentation/auth/forgot_password/view/forgot_password_screen.dart';
import '../../presentation/auth/forgot_password/view/verify_code_screen.dart';
import '../../presentation/auth/forgot_password/view/reset_password_screen.dart';
import '../../presentation/auth/forgot_password/cubit/forgot_password_cubit.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case PageRouteName.login:
        return _handleMaterialPageRoute(widget: LoginScreen());
      case PageRouteName.mainSignUp:
        return _handleMaterialPageRoute(widget: SignUpPage());
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
