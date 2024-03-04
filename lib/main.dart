import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/provider/auth_provider.dart';
import 'data/provider/language_provider.dart';
import 'data/provider/theme_provider.dart';
import 'myapp.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

