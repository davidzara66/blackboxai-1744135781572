import 'package:flutter/material.dart';

class LocalizationService {
  final Locale locale;

  LocalizationService(this.locale);

  static LocalizationService of(BuildContext context) {
    return Localizations.of<LocalizationService>(context, LocalizationService)!;
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'Financial Manager',
      'inventory': 'Inventory',
      'reports': 'Reports',
      'sales': 'Sales',
      'purchases': 'Purchases',
      // Add more English translations
    },
    'es': {
      'appTitle': 'Gestor Financiero',
      'inventory': 'Inventario',
      'reports': 'Reportes',
      'sales': 'Ventas',
      'purchases': 'Compras',
      'settings': 'Ajustes',
      'currency_preference': 'Moneda preferida',
      'language': 'Idioma',
      'auto_update_rates': 'Actualizar tasas automáticamente',
      // Add more Spanish translations
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }

  static const supportedLocales = [
    Locale('en', 'US'),
    Locale('es', 'VE'),
  ];

  String formatCurrency(double amount) {
    return NumberFormat.currency(
      symbol: locale.languageCode == 'es' ? 'Bs.' : '\$',
      decimalDigits: 2,
    ).format(amount);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy', locale.languageCode).format(date);
  }

  String formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time); // Military time
  }
}