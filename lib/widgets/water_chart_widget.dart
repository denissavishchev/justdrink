import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../constants.dart';
import '../models/water_daily_model.dart';

class WaterChartWidget extends StatefulWidget {
  const WaterChartWidget({
    super.key,
    required this.daily,
  });

  final List<WaterDailyModel> daily;

  @override
  State<WaterChartWidget> createState() => _WaterChartWidgetState();
}

class _WaterChartWidgetState extends State<WaterChartWidget> {

  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
        enablePanning: true, zoomMode: ZoomMode.x);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        plotAreaBorderColor: Colors.transparent,
        enableAxisAnimation: true,
        zoomPanBehavior: _zoomPanBehavior,
        primaryXAxis: DateTimeCategoryAxis(
          isVisible: true,
          labelRotation: 90,
          visibleMinimum: DateTime.parse(widget.daily.last.dateTime)
              .subtract(const Duration(days: 7)),
          intervalType: DateTimeIntervalType.days,
          axisLine: const AxisLine(color: Colors.transparent),
          dateFormat: DateFormat('d MMM'),
          labelStyle: const TextStyle(color: kWhite),
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
          ColumnSeries<WaterDailyModel, DateTime>(
              dataSource: widget.daily,
              xValueMapper: (WaterDailyModel data, _) => DateTime.parse(data.dateTime),
              yValueMapper: (WaterDailyModel data, _) => data.percentMl > 100
                  ? 100 : data.percentMl,
              width: 0.45,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
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
              borderWidth: 1,
              color: kOrange,
              gradient: LinearGradient(
                  colors: [kOrange.withOpacity(0.4), kBlue.withOpacity(0.4)],
                  stops: const [0.3, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              ),
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
    );
  }
}