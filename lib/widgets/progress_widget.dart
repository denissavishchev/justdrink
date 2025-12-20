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
              borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(130)),
              border: Border.all(width: 0.5, color: kOrange),
              boxShadow: [
                BoxShadow(
                    color: kGrey.withValues(alpha: 0.8),
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
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: kBlue,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: kWhite,
                            blurRadius: 20,
                            offset: Offset(-10, -10)
                        ),
                        BoxShadow(
                            color: kGrey,
                            blurRadius: 20,
                            offset: Offset(10, 10)
                        ),
                      ]
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.1, color: kOrange),
                      boxShadow: const [
                        BoxShadow(color: kBlue, blurRadius: 5),
                        BoxShadow(color: kWhite, blurRadius: 20, spreadRadius: 5),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(160)),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          kBlue,
                          kWhite,
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 235,
                  height: 235,
                  child: CircularProgressIndicator(
                    value: water.percent / 100,
                    backgroundColor: kGreen.withValues(alpha: 0.3),
                    strokeWidth: 20,
                    color: kGreen.withValues(alpha: 0.8),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                daily.isEmpty
                    ? const Text('Just drink')
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 5,),
                        Text('${daily.isEmpty || daily.last.dateMl != DateTime.now().day.toString()
                             ? 0 : daily.last.percentMl} %',
                          style: kOrangeStyle.copyWith(fontSize: 24),),
                        Text('${daily.isEmpty || daily.last.dateMl != DateTime.now().day.toString()
                            ? 0 : daily.last.portionMl} / ${water.target}',
                          style: kOrangeStyle.copyWith(fontSize: 20),),
                        Text('ml', style: kOrangeStyle,)
                  ],
                ),
              ],
            ),
          );
        });
  }
}