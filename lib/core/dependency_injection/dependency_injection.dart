import 'dart:developer';

import 'package:get_it/get_it.dart';
import 'package:stock_market/core/networks/http_service.dart';
import 'package:stock_market/features/stock_chart/injection/stock_chart_injection.dart';

GetIt locator = GetIt.I;
Future<void> setUpLocator() async {
  log('locator regiters', name: "locator register");
  locator.registerLazySingleton(() => DioHttpService());
  StockInjection.register();
}
