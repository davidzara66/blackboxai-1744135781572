import 'package:flutter/material.dart';
import 'package:financial_manager/services/localization_service.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<LocalizationService> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return LocalizationService.supportedLocales
        .any((supported) => supported.languageCode == locale.languageCode);
  }

  @override
  Future<LocalizationService> load(Locale locale) async {
    return LocalizationService(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}