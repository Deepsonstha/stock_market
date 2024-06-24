// ignore_for_file: public_member_api_docs, sort_constructors_first
class DailyModel {
  final double? price;
  final String? dayOfWeek;
  final String? datetime;

  DailyModel({
    this.price,
    this.dayOfWeek,
    this.datetime,
  });

  factory DailyModel.fromMap(Map<String, dynamic> json) => DailyModel(
        price: json["price"]?.toDouble(),
        dayOfWeek: json["day_of_week"],
        datetime: json["datetime"],
      );

  Map<String, dynamic> toMap() => {
        "price": price,
        "day_of_week": dayOfWeek,
        "datetime": datetime,
      };

  @override
  bool operator ==(covariant DailyModel other) {
    if (identical(this, other)) return true;

    return other.price == price && other.dayOfWeek == dayOfWeek && other.datetime == datetime;
  }

  @override
  int get hashCode => price.hashCode ^ dayOfWeek.hashCode ^ datetime.hashCode;

  @override
  String toString() => 'DailyModel(price: $price, dayOfWeek: $dayOfWeek, datetime: $datetime)';

  DailyModel copyWith({
    double? price,
    String? dayOfWeek,
    String? datetime,
  }) {
    return DailyModel(
      price: price ?? this.price,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      datetime: datetime ?? this.datetime,
    );
  }
}
