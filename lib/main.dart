import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'myapp.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(
    const TaskManager(),
  );
}
