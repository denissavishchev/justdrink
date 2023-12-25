import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/water_daily_model.dart';
import '../providers/water_provider.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({
    super.key,
    required this.daily,
  });

  final List<WaterDailyModel> daily;

  @override
  Widget build(BuildContext context) {
    return Consumer<WaterProvider>(
        builder: (context, water, _){
          return Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              color: kBlue,
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(130)),
              boxShadow: [
                BoxShadow(
                    color: kGrey.withOpacity(0.8),
                    spreadRadius: 4,
                    blurRadius: 12,
                    offset: const Offset(4, 4)
                )
              ],
            ),
            padding: const EdgeInsets.all(32),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 235,
                  height: 235,
                  child: CircularProgressIndicator(
                    value: water.percent / 100,
                    backgroundColor: kGreen.withOpacity(0.3),
                    strokeWidth: 20,
                    color: kGreen,
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  children: [
                    Text('${daily.last.percentMl} %'),
                    Text('${daily.last.portionMl} / ${water.target}'),
                  ],
                ),
              ],
            ),
          );
        });
  }
}