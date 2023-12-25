import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/boxes.dart';
import '../models/water_daily_model.dart';

class WaterProvider with ChangeNotifier {

  Box box = Hive.box('water_settings');
  String weight = '000';
  int target = 0;
  TimeOfDay initialWakeUpTime = const TimeOfDay(hour: 8, minute: 00);
  TimeOfDay initialBedTime = const TimeOfDay(hour: 22, minute: 00);
  int interval = 1;
  double percent = 0;
  int water = 0;

  void setTarget(int index, int order){
    switch(order){
      case 0:
        weight = (index).toString() + weight.substring(1, 3);
        break;
      case 1:
        weight = weight.substring(0, 1) + index.toString() + weight.substring(2);
        break;
      case 2:
        weight = weight.substring(0, 2) + index.toString();
        break;
    }
    print(weight);
    target = int.parse(weight) * 30;
    notifyListeners();
  }

  void setInterval(int index){
    interval = index;
    notifyListeners();
  }

  Future addPortionToBase(int quantity, Box<WaterDailyModel> box, String date) async {
    water = water + quantity;
    percent = (water / target) * 100;
    if(box.isEmpty) {
      final waterDaily = WaterDailyModel()
        ..dateMl = DateTime.now().day.toString()
        ..targetMl = target
        ..portionMl = water
        ..percentMl = percent.toInt()
        ..dateTime = DateTime.now().toString();
      final box = Boxes.addWaterDailyToBase();
      box.add(waterDaily);
    }else if(box.isNotEmpty && date == DateTime.now().day.toString()){
      box.putAt(box.length - 1, WaterDailyModel()
        ..dateMl = date
        ..targetMl = target
        ..portionMl = water
        ..percentMl = percent.toInt()
        ..dateTime = DateTime.now().toString());
    }else{
      final waterDaily = WaterDailyModel()
        ..dateMl = DateTime.now().day.toString()
        ..targetMl = target
        ..portionMl = water
        ..percentMl = percent.toInt()
        ..dateTime = DateTime.now().toString();
      final box = Boxes.addWaterDailyToBase();
      box.add(waterDaily);
    }
  }

  Future saveSettings() async{
    await box.put('weight', weight);
    await box.put('target', target);
    await box.put('wake', initialWakeUpTime.toString().substring(10, 15));
    await box.put('bed', initialBedTime.toString().substring(10, 15));
    await box.put('interval', interval);
  }

  Future<void> wakeUpTimePicker(context) async {
    initialWakeUpTime = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    )) ?? const TimeOfDay(hour: 8, minute: 00);
    notifyListeners();
  }

  Future<void> bedTimePicker(context) async {
    initialBedTime = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    )) ?? const TimeOfDay(hour: 22, minute: 00);
    notifyListeners();
  }

}