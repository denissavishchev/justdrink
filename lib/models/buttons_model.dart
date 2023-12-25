import 'package:hive/hive.dart';
part 'buttons_model.g.dart';

@HiveType(typeId: 89)
class ButtonsModel extends HiveObject{
  @HiveField(1)
  late int buttons;
}