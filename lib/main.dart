import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/di/di.dart';
import 'core/generated/l10n.dart';
import 'core/local/sign_up_provider.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/page_route_name.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/bloc_observer/app_bloc_observer.dart';
import 'core/utils/functions/providers/local_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();

  configureDependencies(); // Initialize dependency injection
  Bloc.observer = AppBlocObserver();

  LocalProvider localProvider = LocalProvider();
  SignupProvider signupProvider = SignupProvider();

  await localProvider.loadSavedLanguage();
  await signupProvider.loadUserData();

  // Initialize local provider for language settings
  LocalProvider provider = LocalProvider();
  await provider.loadSavedLanguage();

  // Check if user is already logged in (you can implement this logic)
  // final token = await TokenManager.getToken();
  // final initialRoute = token != null ? PageRouteName.home : PageRouteName.login;

  runApp(
    ChangeNotifierProvider(
      create: (context) => provider,
      child: const MyApp(),
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => localProvider),
        ChangeNotifierProvider(create: (context) => signupProvider),
      ],
      child: MyApp(),
    ),
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
          initialRoute: PageRouteName.login, // Change initial route to login
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      },
    );
  }
}
