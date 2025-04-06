import 'package:fitness_app/presentation/online_coach/widget/object_box.dart';
import 'package:fitness_app/presentation/profile/view_model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/provider.dart';
import 'check_internet.dart';
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
  final objectBox = await ObjectBox.create();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => localProvider),
        ChangeNotifierProvider(create: (context) => signupProvider),
        BlocProvider(create: (context) => getIt<ProfileCubit>()),
        Provider<ObjectBox>.value(value: objectBox),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<bool>? initialConnectionCheck;

  @override
  void initState() {
    super.initState();
    initialConnectionCheck = InternetConnection().hasInternetAccess;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocalProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return FutureBuilder<bool>(
          future: initialConnectionCheck,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final bool initialConnection = snapshot.data ?? false;

            return StreamBuilder<InternetStatus>(
              stream: InternetConnection().onStatusChange,
              initialData: initialConnection
                  ? InternetStatus.connected
                  : InternetStatus.disconnected,
              builder: (context, snapshot) {
                final bool isConnected =
                    snapshot.data == InternetStatus.connected;

                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Stack(
                    children: [
                      MaterialApp(
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
                        initialRoute: PageRouteName.login,
                        onGenerateRoute: AppRoutes.onGenerateRoute,
                      ),
                      if (!isConnected)
                        Positioned.fill(child: const NoInternetScreen()),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
