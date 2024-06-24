part of 'stock_chart_bloc.dart';

abstract class StockChartEvent {}

class FetchingLiveMarketEvent extends StockChartEvent {}

class HourlyEvent extends StockChartEvent {}

class DailyEvent extends StockChartEvent {}

class MontlyEvent extends StockChartEvent {}

class YearlyEvent extends StockChartEvent {}
