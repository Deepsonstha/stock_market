import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_market/core/dependency_injection/dependency_injection.dart';
import 'package:stock_market/features/stock_chart/bloc/stock_chart_bloc.dart';

class BlocProvidersList {
  static final blocList = [
    BlocProvider<StockChartBloc>(create: (_) => locator<StockChartBloc>()),
  ];
}
