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
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(130)),
              boxShadow: [
                BoxShadow(
                    color: kGrey,
                    spreadRadius: 4,
                    blurRadius: 12,
                    offset: Offset(4, 4)
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
                    backgroundColor: Colors.deepOrange,
                    strokeWidth: 20,
                    color: Colors.green,
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