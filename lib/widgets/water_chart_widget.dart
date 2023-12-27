import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../constants.dart';
import '../models/water_daily_model.dart';

class WaterChartWidget extends StatelessWidget {
  const WaterChartWidget({
    super.key,
    required this.daily,
  });

  final List<WaterDailyModel> daily;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SfCartesianChart(
          plotAreaBorderColor: Colors.transparent,
          enableAxisAnimation: true,
          primaryXAxis: DateTimeAxis(
            isVisible: true,
            axisLine: const AxisLine(color: Colors.transparent),
            dateFormat: DateFormat('d'),
            // labelRotation: 90,
            labelStyle: const TextStyle(color: kWhite),
            minimum: DateTime.parse(daily.first.dateTime).subtract(
                Duration(
                  days: DateTime.now().day - int.parse(daily.last.dateMl)
                      - (daily.length > 7 ? 7 : 0),
                  hours: 0,
                  minutes: DateTime.now().minute,
                  seconds: DateTime.now().second,
                  milliseconds: DateTime.now().millisecond,
                  microseconds: DateTime.now().millisecond,
                          )),
            majorGridLines: const MajorGridLines(width: 0,),
          ),
          primaryYAxis: CategoryAxis(
            isVisible: true,
            axisLine: const AxisLine(color: Colors.transparent),
            labelStyle: const TextStyle(color: kWhite),
            placeLabelsNearAxisLine: true,
            minimum: 0,
            maximum: 100,
            majorGridLines: const MajorGridLines(width: 0,),
          ),
          series: <CartesianSeries>[
            SplineAreaSeries<WaterDailyModel, DateTime>(
                dataSource: daily,
                xValueMapper: (WaterDailyModel data, _) => DateTime.parse(data.dateTime),
                yValueMapper: (WaterDailyModel data, _) => data.percentMl,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(color: kWhite, fontWeight: FontWeight.bold),
                  margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  borderColor: kGreen,
                  borderWidth: 1,
                  color: kOrange,
                  opacity: 0.8,
                ),
                borderColor: kOrange.withOpacity(0.5),
                borderWidth: 2,
                color: kOrange,
                gradient: LinearGradient(
                    colors: [kOrange.withOpacity(0.4), kBlue.withOpacity(0.4)],
                    stops: const [0.3, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                ),
                splineType: SplineType.cardinal,
                cardinalSplineTension: 0.1,
                markerSettings: const MarkerSettings(
                    isVisible: false,
                    color: kOrange,
                    borderColor: kOrange,
                    width: 2,
                    height: 8
                ),
                animationDuration: 1000
            )
          ]
      ),
    );
  }
}