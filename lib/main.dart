import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:indar_deco/core/l10n/l10n.dart';
import 'package:indar_deco/presentation/controllers/settings_controller.dart';
import 'package:indar_deco/presentation/ui/screens/splash/splash_screen.dart';
import 'di.dart' as di;
import 'package:indar_deco/core/styles/themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (controller) {
        controller.loadLocale();
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          child: MaterialApp(
              title: 'INDAR DECO',
              home: const SplashScreen(),
              supportedLocales: L10n.all,
              debugShowCheckedModeBanner: false,
              locale: Locale(controller.currentlocale), // ?? Locale('fr'),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              theme: AppTheme.lightTheme),
        );
      }, 
    );
  }
}
