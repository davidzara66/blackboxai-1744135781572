import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormattingService {
  static Future<String> getCurrencySymbol() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('currency') ?? 'USD';
  }

  static Future<void> setCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currency', currency);
  }

  static String formatCurrency(double amount, String currency) {
    final format = NumberFormat.currency(
      symbol: currency == 'USD' ? '\$' : 'Bs.',
      decimalDigits: 2,
    );
    return format.format(amount);
  }

  static String formatMilitaryTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static Future<String> formatCurrencyWithExchange(double amount) async {
    final currency = await getCurrencySymbol();
    if (currency == 'VES') {
      final rate = await ExchangeService.getDollarRate();
      if (rate != null) {
        return 'Bs. ${(amount * rate).toStringAsFixed(2)}';
      }
    }
    return formatCurrency(amount, currency);
  }
}