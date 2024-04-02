
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../localization/Language/language_bn.dart';
import '../../localization/Language/language_en.dart';
import '../../localization/Language/languages.dart';

class LanguageController extends GetxController {
  final _box = GetStorage();
  Languages _currentLanguage = LanguageEn(); // Default language

  Languages get currentLanguage => _currentLanguage;

  Future<void> changeLanguage(Languages newLanguage, String language) async {
    _currentLanguage = newLanguage;
    update();

    _box.write('selectedLanguage', language);
  }

  @override
  void onInit() {
    super.onInit();
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    String? selectedLanguage = _box.read('selectedLanguage');
    print(selectedLanguage);

    if (selectedLanguage != null) {
      switch (selectedLanguage) {
        case 'LanguageEn':
          _currentLanguage = LanguageEn();
          print("$selectedLanguage SET");
          break;
        case 'LanguageBn':
          _currentLanguage = LanguageBn();
          print("$selectedLanguage SET");
          break;
      // Add more language cases as needed
      }
      update();
    }
  }

  Locale get locale {
    if (_currentLanguage is LanguageEn) {
      return Locale('en', '');
    } else if (_currentLanguage is LanguageBn) {
      return Locale('bn', '');
    }
    return Locale('en', '');
  }
}
