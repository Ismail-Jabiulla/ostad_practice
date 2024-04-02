import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';
import 'package:untitled/presentation/app_screen/authenication/splash_screen.dart';
import 'data/controller/controller_binder.dart';
import 'data/controller/language_controller.dart';
import 'data/controller/theme_controller.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import flutter_localizations


class TaskManager extends StatelessWidget {
  const TaskManager({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


  @override
  Widget build(BuildContext context) {

    final inputDecorationTheme = InputDecorationTheme(
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      filled: true,
      fillColor: Theme.of(context).colorScheme.onPrimary,
      hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.secondary),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSecondary)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSecondary)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color:Theme.of(context).colorScheme.onSecondary)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.onSecondary)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error)),
    );

    Get.put(ThemeController());

    return GetBuilder<LanguageController>(
      init: LanguageController(), // Initialize LanguageProvider
      builder: (languageProvider) => GetBuilder<ThemeController>(
        init: ThemeController(), // Initialize ThemeProvider
        builder: (themeProvider) => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Task Manager App',
          theme: themeProvider.isDarkMode
              ? ThemeData.dark().copyWith(
              inputDecorationTheme: inputDecorationTheme,
              colorScheme: ColorScheme(
                brightness: Brightness.dark,
                primary: Colors.grey.shade900,
                onPrimary: Colors.grey.shade900,
                secondary: Colors.grey.shade400,
                onSecondary: Colors.grey.shade400,
                error: Colors.red,
                onError: Colors.white,
                background: Colors.black,
                onBackground: Colors.white,
                surface: Colors.grey.shade800,
                onSurface: Colors.black,
              ))
              : ThemeData.light().copyWith(
              inputDecorationTheme: inputDecorationTheme,
              colorScheme: ColorScheme(
                brightness: Brightness.light,
                primary: Colors.grey.shade100,
                onPrimary: Colors.green,
                secondary: Colors.grey.shade800,
                onSecondary: Colors.white,
                error: Colors.red,
                onError: Colors.white,
                background: Colors.grey.shade50,
                onBackground: Colors.white,
                surface: Colors.green,
                onSurface: Colors.transparent,
              )),
          initialBinding: ControllerBinder(),
          home: const SplashScreen(),

          supportedLocales: const [
            Locale('en', ''),
            Locale('bn', ''),
          ],

          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],

          localeResolutionCallback: (locale, supportedLocales) {
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
        ),
      ),
    );
  }
}
