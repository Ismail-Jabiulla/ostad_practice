import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/provider/language_provider.dart';
import 'package:untitled/provider/theme_provider.dart';
import 'myapp.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

