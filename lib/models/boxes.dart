import 'package:hive/hive.dart';
import 'package:justdrink/models/water_daily_model.dart';
import 'buttons_model.dart';

class Boxes {
  static Box<WaterDailyModel> addWaterDailyToBase() =>
      Hive.box<WaterDailyModel>('water_daily');
  static Box<ButtonsModel> addButtonToBase() =>
      Hive.box<ButtonsModel>('buttons');
}