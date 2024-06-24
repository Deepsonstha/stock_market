// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stock_market/core/constants/constants.dart';
import 'package:stock_market/features/stock_chart/bloc/stock_chart_bloc.dart';
import 'package:stock_market/features/stock_chart/bloc/stock_chart_state.dart';
import 'package:stock_market/features/stock_chart/models/stock_model.dart';
import 'package:stock_market/features/stock_chart/screens/home_screen.dart';
import 'package:stock_market/features/stock_chart/widgets/kselect_timeline_card.dart';

import '../../../core/helpers/exports.dart';

export 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StockChartBloc>().add(FetchingLiveMarketEvent());
    context.read<StockChartBloc>().add(HourlyEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.withOpacity(0.08),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 16.h),
          child: BlocBuilder<StockChartBloc, StockChartState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  return context.read<StockChartBloc>().add(FetchingLiveMarketEvent());
                },
                child: Column(
                  children: [
                    _topPriceShowSection(context: context, state: state),
                    SizedBox(height: 20.h),
                    _lineChartSecton(state: state),
                    SizedBox(height: 20.h),
                    _timeLIneSecton(context: context, state: state),
                  ],
                ),
              );
            },
          ),
        ));
  }

  _timeLIneSecton({
    required BuildContext context,
    required StockChartState state,
  }) {
    return SizedBox(
        height: 50.h,
        width: 1.sw,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: KSelectTImeLineCardWIdget(
                timeLineLabel: '1H',
                onTap: () {
                  context.read<StockChartBloc>().add(HourlyEvent());
                },
                backgroundColor: state.selectedTimeLine == AppConstants.hourly ? const Color.fromARGB(255, 5, 209, 232) : Colors.white,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: KSelectTImeLineCardWIdget(
                timeLineLabel: '1D',
                onTap: () {
                  context.read<StockChartBloc>().add(DailyEvent());
                },
                backgroundColor: state.selectedTimeLine == AppConstants.daily ? const Color.fromARGB(255, 5, 209, 232) : Colors.white,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: KSelectTImeLineCardWIdget(
                timeLineLabel: '1M',
                onTap: () {
                  context.read<StockChartBloc>().add(MontlyEvent());
                },
                backgroundColor: state.selectedTimeLine == AppConstants.monthly ? const Color.fromARGB(255, 5, 209, 232) : Colors.white,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: KSelectTImeLineCardWIdget(
                timeLineLabel: '1Y',
                onTap: () {
                  context.read<StockChartBloc>().add(YearlyEvent());
                },
                backgroundColor: state.selectedTimeLine == AppConstants.yearly ? const Color.fromARGB(255, 5, 209, 232) : Colors.white,
              ),
            ),
          ],
        ));
  }

  _lineChartSecton({required StockChartState state}) {
    //! flspot data
    List<FlSpot> flspotData;
    switch (state.selectedTimeLine) {
      case AppConstants.hourly:
        flspotData = state.hourlyFlspotData!;
        break;
      case AppConstants.daily:
        flspotData = state.dailyFlspotData!;
        break;
      case AppConstants.monthly:
        flspotData = state.montlyFlspotData!;
        break;
      case AppConstants.yearly:
        flspotData = state.yearlyFlspotData!;
        break;
      default:
        flspotData = state.hourlyFlspotData!;
    }

    return SizedBox(
      height: 200.h,
      width: 1.sw,
      child: LineChart(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        LineChartData(
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((barSpot) {
                    int index = barSpot.x.toInt();
                    final flSpot = barSpot;

                    String? week;
                    switch (state.selectedTimeLine) {
                      case AppConstants.hourly:
                        week = state.marketData?[0].hourly?[index].dayOfWeek;
                        break;
                      case AppConstants.daily:
                        week = state.marketData?[0].daily?[index].dayOfWeek;
                        break;
                      case AppConstants.monthly:
                        week = state.marketData?[0].monthly?[index].dayOfWeek;
                        break;
                      case AppConstants.yearly:
                        week = state.marketData?[0].yearly?[index].dayOfWeek;
                        break;
                      default:
                        week = state.marketData?[0].hourly?[index].dayOfWeek;
                    }

                    DateTime dateTime;
                    switch (state.selectedTimeLine) {
                      case AppConstants.hourly:
                        dateTime = DateTime.parse(state.marketData![0].hourly![index].datetime.toString());
                        break;
                      case AppConstants.daily:
                        dateTime = DateTime.parse(state.marketData![0].daily![index].datetime.toString());
                        break;
                      case AppConstants.monthly:
                        dateTime = DateTime.parse(state.marketData![0].monthly![index].datetime.toString());
                        break;
                      case AppConstants.yearly:
                        dateTime = DateTime.parse(state.marketData![0].yearly![index].datetime.toString());
                        break;
                      default:
                        dateTime = DateTime.parse(state.marketData![0].hourly![index].datetime.toString());
                    }

                    //! time formatter

                    DateFormat formatter = DateFormat('MMM d,yyyy HH:mm:ss');
                    String formattedDate = formatter.format(dateTime);

                    return LineTooltipItem(
                      state.selectedTimeLine == AppConstants.yearly ? '$formattedDate\n' : '$week,$formattedDate\n',
                      Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                      children: [
                        TextSpan(
                          text: 'Rs.${numberformat.format(flSpot.y)}',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                        ),
                      ],
                    );
                  }).toList();
                },
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                dotData: const FlDotData(show: false),
                spots: flspotData,
                isCurved: true,
                color: Colors.green.shade700,
                isStrokeJoinRound: true,
                preventCurveOverShooting: true,
              ),
            ],
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  dashArray: [
                    8,
                  ],
                  color: Colors.grey.shade300,
                  strokeWidth: 0.7,
                );
              },
              drawVerticalLine: false,
            ),
            titlesData: const FlTitlesData(show: false)

            // ),
            ),
      ),
    );
  }

  _topPriceShowSection({
    required BuildContext context,
    required StockChartState state,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _top_stockprice_dropdown_section(state, context),
        SizedBox(height: 10.h),
        _top_price_increase_percentage_section(context, state),
        SizedBox(height: 10.h),
        _close_in_section(context),
      ],
    );
  }

  _close_in_section(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'As of May 09, 2024 03:00 PM',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
        Center(
          child: Text(
            'Closes in 3 hrs 9 min',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ],
    );
  }

  _top_price_increase_percentage_section(BuildContext context, StockChartState state) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                '2.1 Ar',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(width: 5.w),
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.arrowTrendUp,
                    color: Colors.green,
                    size: 20,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    '${state.marketData?.first.todayIncrement ?? ""}(${state.marketData?.first.percentage ?? ""}%)',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
        Row(
          children: [
            CircleAvatar(
              radius: 4.r,
              backgroundColor: Colors.green,
            ),
            SizedBox(width: 10.w),
            Center(
              child: Text(
                "Market",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              "OPEN",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Row _top_stockprice_dropdown_section(StockChartState state, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            state.marketData?.first.stockPrice ?? "0.00",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 130,
          child: DropdownButtonFormField<StockModel>(
            value: state.marketData?[0],
            onChanged: (newValue) {},
            items: state.marketData?.map<DropdownMenuItem<StockModel>>((value) {
              return DropdownMenuItem<StockModel>(
                value: value,
                child: Text(value.stockName.toString()),
              );
            }).toList(),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(30.r),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
