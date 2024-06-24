// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:stock_market/core/constants/constants.dart';
import 'package:stock_market/core/errors/error_handler.dart';
import 'package:stock_market/features/stock_chart/models/stock_model.dart';
import 'package:stock_market/features/stock_chart/screens/home_screen.dart';

class StockChartState {
  final bool isLoadingState;
  final bool isSuccessState;
  final AppErrorHandler? errorState;
  final List<StockModel>? marketData;
  final String? selectedTimeLine;

//hourly data
  final List<double>? hourlyIndexValue;
  final List<FlSpot>? hourlyFlspotData;

  //daily data
  final List<double>? dailyIndexValue;
  final List<FlSpot>? dailyFlspotData;

  //montly data
  final List<double>? montlyIndexValue;
  final List<FlSpot>? montlyFlspotData;

  //yearly data
  final List<double>? yearlyIndexValue;
  final List<FlSpot>? yearlyFlspotData;

  StockChartState({
    required this.isLoadingState,
    required this.isSuccessState,
    required this.errorState,
    required this.marketData,
    this.selectedTimeLine,
    this.hourlyIndexValue,
    this.hourlyFlspotData,
    this.dailyIndexValue,
    this.dailyFlspotData,
    this.montlyIndexValue,
    this.montlyFlspotData,
    this.yearlyIndexValue,
    this.yearlyFlspotData,
  });

  factory StockChartState.initially() {
    return StockChartState(
      isLoadingState: false,
      isSuccessState: false,
      errorState: null,
      marketData: null,
      hourlyFlspotData: [],
      hourlyIndexValue: [],
      dailyFlspotData: [],
      dailyIndexValue: [],
      montlyFlspotData: [],
      montlyIndexValue: [],
      yearlyFlspotData: [],
      selectedTimeLine: AppConstants.hourly,
    );
  }

  StockChartState copyWith({
    bool? isLoadingState,
    bool? isSuccessState,
    AppErrorHandler? errorState,
    List<StockModel>? marketData,
    String? selectedTimeLine,
    List<double>? hourlyIndexValue,
    List<FlSpot>? hourlyFlspotData,
    List<double>? dailyIndexValue,
    List<FlSpot>? dailyFlspotData,
    List<double>? montlyIndexValue,
    List<FlSpot>? montlyFlspotData,
    List<double>? yearlyIndexValue,
    List<FlSpot>? yearlyFlspotData,
  }) {
    return StockChartState(
      isLoadingState: isLoadingState ?? this.isLoadingState,
      isSuccessState: isSuccessState ?? this.isSuccessState,
      errorState: errorState ?? this.errorState,
      marketData: marketData ?? this.marketData,
      selectedTimeLine: selectedTimeLine ?? this.selectedTimeLine,
      hourlyIndexValue: hourlyIndexValue ?? this.hourlyIndexValue,
      hourlyFlspotData: hourlyFlspotData ?? this.hourlyFlspotData,
      dailyIndexValue: dailyIndexValue ?? this.dailyIndexValue,
      dailyFlspotData: dailyFlspotData ?? this.dailyFlspotData,
      montlyIndexValue: montlyIndexValue ?? this.montlyIndexValue,
      montlyFlspotData: montlyFlspotData ?? this.montlyFlspotData,
      yearlyIndexValue: yearlyIndexValue ?? this.yearlyIndexValue,
      yearlyFlspotData: yearlyFlspotData ?? this.yearlyFlspotData,
    );
  }

  @override
  String toString() {
    return 'StockChartState(isLoadingState: $isLoadingState, isSuccessState: $isSuccessState, errorState: $errorState, marketData: $marketData, selectedTimeLine: $selectedTimeLine, hourlyIndexValue: $hourlyIndexValue, hourlyFlspotData: $hourlyFlspotData, dailyIndexValue: $dailyIndexValue, dailyFlspotData: $dailyFlspotData, montlyIndexValue: $montlyIndexValue, montlyFlspotData: $montlyFlspotData, yearlyIndexValue: $yearlyIndexValue, yearlyFlspotData: $yearlyFlspotData)';
  }

  @override
  bool operator ==(covariant StockChartState other) {
    if (identical(this, other)) return true;

    return other.isLoadingState == isLoadingState &&
        other.isSuccessState == isSuccessState &&
        other.errorState == errorState &&
        listEquals(other.marketData, marketData) &&
        other.selectedTimeLine == selectedTimeLine &&
        listEquals(other.hourlyIndexValue, hourlyIndexValue) &&
        listEquals(other.hourlyFlspotData, hourlyFlspotData) &&
        listEquals(other.dailyIndexValue, dailyIndexValue) &&
        listEquals(other.dailyFlspotData, dailyFlspotData) &&
        listEquals(other.montlyIndexValue, montlyIndexValue) &&
        listEquals(other.montlyFlspotData, montlyFlspotData) &&
        listEquals(other.yearlyIndexValue, yearlyIndexValue) &&
        listEquals(other.yearlyFlspotData, yearlyFlspotData);
  }

  @override
  int get hashCode {
    return isLoadingState.hashCode ^
        isSuccessState.hashCode ^
        errorState.hashCode ^
        marketData.hashCode ^
        selectedTimeLine.hashCode ^
        hourlyIndexValue.hashCode ^
        hourlyFlspotData.hashCode ^
        dailyIndexValue.hashCode ^
        dailyFlspotData.hashCode ^
        montlyIndexValue.hashCode ^
        montlyFlspotData.hashCode ^
        yearlyIndexValue.hashCode ^
        yearlyFlspotData.hashCode;
  }
}
