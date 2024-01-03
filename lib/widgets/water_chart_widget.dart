import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justdrink/constants.dart';
import '../models/water_daily_model.dart';

class WaterChartWidget extends StatelessWidget {
  const WaterChartWidget({Key? key,
    required this.daily}) : super(key: key);

  final List<WaterDailyModel> daily;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      reverse: true,
      itemCount: daily.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
        return Padding(
          padding: const EdgeInsets.only(right: 12, top: 8, bottom: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 28,
                height: 22,
                decoration: BoxDecoration(
                  color: kOrange.withOpacity(0.8),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  border: Border.all(width: 0.8, color: kGreen.withOpacity(0.7))
                ),
                child: Center(
                  child: Text('${daily[index].percentMl > 100
                      ? 100
                      : daily[index].percentMl}',
                  style: const TextStyle(color: kWhite, fontWeight: FontWeight.bold),),
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
                child: Column(
                  children: [
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                          border: Border.all(width: 1, color: kOrange.withOpacity(0.5)),
                          gradient: LinearGradient(
                              colors: [kOrange.withOpacity(0.4), kBlue.withOpacity(0.4)],
                              stops: const [0.3, 1],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter
                          )
                      ),
                      height: daily[index].percentMl.toDouble() * 1.5,
                      width: 36,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                      DateFormat('d').format(DateTime.parse(daily[index].dateTime)),
                  style: TextStyle(
                      color: kOrange.withOpacity(0.8),
                      fontWeight: FontWeight.bold),),
                  const SizedBox(width: 10,),
                  Text(
                      DateFormat('MMM').format(DateTime.parse(daily[index].dateTime)),
                  style: TextStyle(
                      color: kOrange.withOpacity(0.8),
                      fontWeight: FontWeight.bold),),
                ],
              ),
            ],
          ),
        );
        });
  }
}
