// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:stock_market/features/stock_chart/models/daily_model.dart';

class StockModel {
  final String? stockName;
  final String? stockPrice;
  final String? todayIncrement;
  final String? percentage;
  final DateTime? date;
  final String? time;
  final List<DailyModel>? hourly;
  final List<DailyModel>? daily;
  final List<DailyModel>? monthly;
  final List<DailyModel>? yearly;

  StockModel({
    this.stockName,
    this.stockPrice,
    this.todayIncrement,
    this.percentage,
    this.date,
    this.time,
    this.hourly,
    this.daily,
    this.monthly,
    this.yearly,
  });

  factory StockModel.fromMap(Map<String, dynamic> json) => StockModel(
        stockName: json["stock_name"],
        stockPrice: json["stock_price"],
        todayIncrement: json["today_increment"],
        percentage: json["percentage"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"],
        hourly: json["hourly"] == null ? [] : List<DailyModel>.from(json["hourly"]!.map((x) => DailyModel.fromMap(x))),
        daily: json["daily"] == null ? [] : List<DailyModel>.from(json["daily"]!.map((x) => DailyModel.fromMap(x))),
        monthly: json["monthly"] == null ? [] : List<DailyModel>.from(json["monthly"]!.map((x) => DailyModel.fromMap(x))),
        yearly: json["yearly"] == null ? [] : List<DailyModel>.from(json["yearly"]!.map((x) => DailyModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "stock_name": stockName,
        "stock_price": stockPrice,
        "today_increment": todayIncrement,
        "percentage": percentage,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
        "hourly": hourly == null ? [] : List<dynamic>.from(hourly!.map((x) => x.toMap())),
        "daily": daily == null ? [] : List<dynamic>.from(daily!.map((x) => x.toMap())),
        "monthly": monthly == null ? [] : List<dynamic>.from(monthly!.map((x) => x.toMap())),
        "yearly": yearly == null ? [] : List<dynamic>.from(yearly!.map((x) => x.toMap())),
      };

  static List<StockModel> fromListMap(List<dynamic> data) {
    return data.map((e) => StockModel.fromMap(e)).toList();
  }

  StockModel copyWith({
    String? stockName,
    String? stockPrice,
    String? todayIncrement,
    String? percentage,
    DateTime? date,
    String? time,
    List<DailyModel>? hourly,
    List<DailyModel>? daily,
    List<DailyModel>? monthly,
    List<DailyModel>? yearly,
  }) {
    return StockModel(
      stockName: stockName ?? this.stockName,
      stockPrice: stockPrice ?? this.stockPrice,
      todayIncrement: todayIncrement ?? this.todayIncrement,
      percentage: percentage ?? this.percentage,
      date: date ?? this.date,
      time: time ?? this.time,
      hourly: hourly ?? this.hourly,
      daily: daily ?? this.daily,
      monthly: monthly ?? this.monthly,
      yearly: yearly ?? this.yearly,
    );
  }

  @override
  String toString() {
    return 'StockModel(stockName: $stockName, stockPrice: $stockPrice, todayIncrement: $todayIncrement, percentage: $percentage, date: $date, time: $time, hourly: $hourly, daily: $daily, monthly: $monthly, yearly: $yearly)';
  }

  @override
  bool operator ==(covariant StockModel other) {
    if (identical(this, other)) return true;

    return other.stockName == stockName &&
        other.stockPrice == stockPrice &&
        other.todayIncrement == todayIncrement &&
        other.percentage == percentage &&
        other.date == date &&
        other.time == time &&
        listEquals(other.hourly, hourly) &&
        listEquals(other.daily, daily) &&
        listEquals(other.monthly, monthly) &&
        listEquals(other.yearly, yearly);
  }

  @override
  int get hashCode {
    return stockName.hashCode ^
        stockPrice.hashCode ^
        todayIncrement.hashCode ^
        percentage.hashCode ^
        date.hashCode ^
        time.hashCode ^
        hourly.hashCode ^
        daily.hashCode ^
        monthly.hashCode ^
        yearly.hashCode;
  }
}
