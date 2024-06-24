import 'package:stock_market/core/dependency_injection/dependency_injection.dart';
import 'package:stock_market/features/stock_chart/bloc/stock_chart_bloc.dart';
import 'package:stock_market/features/stock_chart/repository/stock_market_repository.dart';

class StockInjection {
  static register() {
    locator.registerLazySingleton(() => StockMarketRepository(dio: locator()));
    locator.registerFactory(() => StockChartBloc(repository: locator()));
  }
}
