import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homescreen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Application',
      home: HomeScreen(),
    );
  }
}
