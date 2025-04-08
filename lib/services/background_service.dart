import 'package:workmanager/workmanager.dart';
import 'package:financial_manager/services/exchange_service.dart';

class BackgroundService {
  static void initialize() {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    Workmanager().registerPeriodicTask(
      'rateUpdate',
      'updateExchangeRates',
      frequency: const Duration(hours: 12),
    );
  }

  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      if (task == 'updateExchangeRates') {
        await ExchangeService.getDollarRate();
        return true;
      }
      return false;
    });
  }
}