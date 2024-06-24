// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:stock_market/core/constants/constants.dart';
import 'package:stock_market/core/helpers/exports.dart';
import 'package:stock_market/features/stock_chart/bloc/stock_chart_state.dart';
import 'package:stock_market/features/stock_chart/repository/stock_market_repository.dart';
import 'package:stock_market/features/stock_chart/screens/home_screen.dart';

part 'stock_chart_event.dart';

class StockChartBloc extends Bloc<StockChartEvent, StockChartState> {
  final StockMarketRepository repository;
  StockChartBloc({
    required this.repository,
  }) : super(StockChartState.initially()) {
    on<FetchingLiveMarketEvent>(_fetchStockLiveMarket);
    on<HourlyEvent>(_hourlylyHandler);
    on<DailyEvent>(_dailylyHandler);
    on<MontlyEvent>(_monthlyHandler);
    on<YearlyEvent>(_yearlyHandler);
  }

  //! hourly data hand
  void _hourlylyHandler(HourlyEvent event, Emitter<StockChartState> emit) {
    List<double> hourlyIndexValued = [];
    List<FlSpot> hourlyFlspotData = [];
    if (state.isSuccessState && state.marketData!.isNotEmpty) {
      for (var e in state.marketData!) {
        e.hourly?.forEach((e) {
          hourlyIndexValued.add(double.parse(e.price.toString()));
          hourlyFlspotData.add(FlSpot(hourlyIndexValued.length.toDouble() - 1, double.parse(e.price.toString())));
        });
      }
    }
    emit(state.copyWith(
      selectedTimeLine: AppConstants.hourly,
      hourlyIndexValue: hourlyIndexValued,
      hourlyFlspotData: hourlyFlspotData,
    ));
  }

//! daily data hand
  void _dailylyHandler(DailyEvent event, Emitter<StockChartState> emit) {
    List<double> dailyIndexValued = [];
    List<FlSpot> dailyFlspotData = [];
    if (state.isSuccessState && state.marketData!.isNotEmpty) {
      for (var e in state.marketData!) {
        e.daily?.forEach((e) {
          dailyIndexValued.add(double.parse(e.price.toString()));
          dailyFlspotData.add(FlSpot(dailyIndexValued.length.toDouble() - 1, double.parse(e.price.toString())));
        });
      }
    }
    emit(state.copyWith(
      selectedTimeLine: AppConstants.daily,
      dailyIndexValue: dailyIndexValued,
      dailyFlspotData: dailyFlspotData,
    ));
  }

  //! monthly data hand
  void _monthlyHandler(MontlyEvent event, Emitter<StockChartState> emit) {
    List<double> monthlyIndexValued = [];
    List<FlSpot> monthlyFlspotData = [];
    if (state.isSuccessState && state.marketData!.isNotEmpty) {
      for (var e in state.marketData!) {
        e.monthly?.forEach((e) {
          monthlyIndexValued.add(double.parse(e.price.toString()));
          monthlyFlspotData.add(FlSpot(monthlyIndexValued.length.toDouble() - 1, double.parse(e.price.toString())));
        });
      }
    }
    emit(state.copyWith(
      selectedTimeLine: AppConstants.monthly,
      montlyIndexValue: monthlyIndexValued,
      montlyFlspotData: monthlyFlspotData,
    ));
  }

  //! yearly data hand
  void _yearlyHandler(YearlyEvent event, Emitter<StockChartState> emit) {
    List<double> yearlyIndexValued = [];
    List<FlSpot> yearlyFlspotData = [];
    if (state.isSuccessState && state.marketData!.isNotEmpty) {
      for (var e in state.marketData!) {
        e.yearly?.forEach((e) {
          yearlyIndexValued.add(double.parse(e.price.toString()));
          yearlyFlspotData.add(FlSpot(yearlyIndexValued.length.toDouble() - 1, double.parse(e.price.toString())));
        });
      }
    }
    emit(state.copyWith(
      selectedTimeLine: AppConstants.yearly,
      yearlyIndexValue: yearlyIndexValued,
      yearlyFlspotData: yearlyFlspotData,
    ));
  }

//! fetch live market data
  void _fetchStockLiveMarket(FetchingLiveMarketEvent event, Emitter<StockChartState> emit) async {
    emit(state.copyWith(isLoadingState: true));
    EasyLoading.show(
      status: 'Fetching...',
      maskType: EasyLoadingMaskType.black,
    ); //for loading

    final result = await repository.getStockMarket();
    result.fold((error) {
      EasyLoading.dismiss(); //for dismiss
      emit(state.copyWith(
        isLoadingState: false,
        isSuccessState: false,
        errorState: error,
      ));
    }, (success) {
      EasyLoading.dismiss(); //for dismiss
      add(HourlyEvent()); // for calling initially
      emit(state.copyWith(
        isLoadingState: false,
        isSuccessState: true,
        marketData: success,
      ));
    });
  }
}
