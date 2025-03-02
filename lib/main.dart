import 'package:fitness_app/presentation/auth/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:fitness_app/presentation/auth/login/view_model/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/di/di.dart';
import 'core/local/sign_up_provider.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/page_route_name.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/bloc_observer/app_bloc_observer.dart';
import 'core/utils/functions/providers/local_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  Bloc.observer = AppBlocObserver();
  LocalProvider localProvider = LocalProvider();
  SignupProvider signupProvider = SignupProvider();
  await localProvider.loadSavedLanguage();
  await signupProvider.loadUserData();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(create: (context) => getIt<LoginCubit>()),
        BlocProvider(create: (context) => getIt<ForgotPasswordCubit>()),
        ChangeNotifierProvider(create: (context) => localProvider),
        ChangeNotifierProvider(create: (context) => signupProvider),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          locale: Locale(provider.locale),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: AppTheme.appTheme,
          initialRoute: PageRouteName.onBoarding,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}
