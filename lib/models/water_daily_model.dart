import 'package:hive/hive.dart';
part 'water_daily_model.g.dart';

@HiveType(typeId: 79)
class WaterDailyModel extends HiveObject{
  @HiveField(0)
  late String dateMl;
  @HiveField(1)
  late int targetMl;
  @HiveField(2)
  late int portionMl;
  @HiveField(3)
  late int percentMl;
  @HiveField(4)
  late String dateTime;
}