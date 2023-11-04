import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/config/routes/app_route.dart';
import 'package:flutter_task/config/theme/app_theme.dart';
import 'package:flutter_task/core/cache/cache_manger.dart';
import 'package:flutter_task/core/network/api_manager.dart';
import 'package:flutter_task/features/splash/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiManager.init();
  CacheManager.init();
  runApp(
    // const MyApp()
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations', //  the path of the translation files
      fallbackLocale: const Locale('ar'),
      saveLocale: true,
      startLocale: const Locale('ar'),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: getApplicationTheme(),
        onGenerateRoute: AppRoutes.appRoutes,
        home: const SplashScreen(),
      ),
    );
  }
}
