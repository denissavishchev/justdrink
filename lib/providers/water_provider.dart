import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:justdrink/widgets/button_widget.dart';
import '../constants.dart';
import '../models/boxes.dart';
import '../models/buttons_model.dart';
import '../models/water_daily_model.dart';
import '../pages/settings_page.dart';
import '../pages/water_page.dart';
import '../widgets/icon_svg_widget.dart';

class WaterProvider with ChangeNotifier {

  Box box = Hive.box('water_settings');
  String weight = '000';
  int target = 0;
  TimeOfDay initialWakeUpTime = const TimeOfDay(hour: 8, minute: 00);
  TimeOfDay initialBedTime = const TimeOfDay(hour: 22, minute: 00);
  int interval = 1;
  double percent = 0;
  int water = 0;
  bool kg = true;
  bool dark = false;
  String hydration = '0';
  List<WaterDailyModel> waterDaily = [];
  List<int> totalPercents = [];

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
    target = int.parse(weight) * 30;
    notifyListeners();
  }

  void setInterval(int index){
    interval = index;
    notifyListeners();
  }

  void kgLbs(){
    kg = !kg;
    notifyListeners();
  }

  void darkMode(){
    dark = !dark;
    notifyListeners();
  }

  void toSettingsPage(context, Box settings){
    target = settings.get('target') ?? 0;
    weight = settings.get('weight') ?? '000';
    initialWakeUpTime = settings.get('wake') == null
        ? const TimeOfDay(hour: 8, minute: 00)
        : TimeOfDay(hour: int.parse(settings.get('wake').split(":")[0]),
        minute: int.parse(settings.get('wake').split(":")[1]));
    initialBedTime = settings.get('bed') == null
        ? const TimeOfDay(hour: 22, minute: 00)
        : TimeOfDay(hour: int.parse(settings.get('bed').split(":")[0]),
        minute: int.parse(settings.get('bed').split(":")[1]));
    kg = settings.get('kg') ?? true;
    dark = settings.get('dark') ?? false;
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>
        const SettingsPage()));
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
    notifyListeners();
  }

  Future createMl(context, bool button, Box<WaterDailyModel> box, String date) {
    return showModalBottomSheet( 
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                right: 14),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                clipBehavior: Clip.hardEdge,
                height: MediaQuery.of(context).size.height * 0.8,
                width: 100,
                margin: const EdgeInsets.fromLTRB(0, 12, 0, 150),
                decoration: BoxDecoration(
                    color: kBlue.withOpacity(0.8),
                    border: Border.all(width: 0.5, color: kOrange),
                    boxShadow: [
                      BoxShadow(
                        color: kGrey.withOpacity(0.8),
                        spreadRadius: 1,
                        blurRadius: 1,
                      )
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(130))
                ),
                child: SingleChildScrollView(
                  physics: const ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      ButtonWidget(
                          child: const IconSvgWidget(icon: 'cancel'),
                          onTap: () => Navigator.of(context).pop()
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: 10,
                        itemBuilder: (context, index){
                          return ButtonWidget(
                            onTap: () {
                              if(button){
                                addButton((index + 1) * 100);
                              }else{
                                addPortionToBase((index + 1) * 100, box, date);
                              }
                              Navigator.of(context).pop();
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                const IconSvgWidget(icon: 'drop', color: kBlue, padding: 10,),
                                Text('${(index + 1) * 100}',
                                  style: kOrangeStyle.copyWith(fontSize: 16),),
                              ],
                            ),);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future deleteMl(int index, context, Box<ButtonsModel> box) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.11,
                margin: const EdgeInsets.fromLTRB(0, 12, 0, 34),
                decoration: BoxDecoration(
                    color: kBlue.withOpacity(0.8),
                    border: Border.all(width: 0.5, color: kOrange),
                    boxShadow: [
                      BoxShadow(
                        color: kGrey.withOpacity(0.8),
                        spreadRadius: 1,
                        blurRadius: 1,
                      )
                    ],
                    borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(130))
                ),
                child: Row(
                  children: [
                    const Spacer(),
                    Text('Delete button?',
                        style: kOrangeStyle.copyWith(fontSize: 22)),
                    const Spacer(),
                    ButtonWidget(
                      child: const IconSvgWidget(icon: 'check',),
                      onTap: () {
                        box.deleteAt(index);
                        Navigator.of(context).pop();
                      },),
                    ButtonWidget(
                        child: const IconSvgWidget(icon: 'cancel',),
                        onTap: () => Navigator.of(context).pop()),
                    const Spacer(),
                  ],
                ),
              ),
              const Spacer(),
            ],
          );
        });
  }

  Future addButton(int value) async{
    final button = ButtonsModel()
      ..buttons = value;
    final box = Boxes.addButtonToBase();
    box.add(button);
  }

  Future saveSettings(context) async{
    await box.put('weight', weight);
    await box.put('target', target);
    await box.put('wake', initialWakeUpTime.toString().substring(10, 15));
    await box.put('bed', initialBedTime.toString().substring(10, 15));
    await box.put('interval', interval);
    await box.put('kg', kg);
    await box.put('dark', dark);
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) =>
        const WaterPage()));
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

  String totalHydration(){
    if(waterDaily.isNotEmpty){
      totalPercents.clear();
      for(var p in waterDaily){
        if(p.percentMl > 100){
          p.percentMl = 100;
        }
        totalPercents.add(p.percentMl);
      }
      var sum = totalPercents.reduce((a, b) => a + b);
      return hydration =  (sum / totalPercents.length).toStringAsFixed(0);
    }else{
      return '0';
    }

  }

  String description(){
    if(int.parse(hydration) >= 90){
      return 'Excellent result';
    }else if(int.parse(hydration) >= 75 && int.parse(hydration) < 90){
      return 'Way to go';
    }else if(int.parse(hydration) >= 50 && int.parse(hydration) < 75){
      return 'Not bad';
    }else{
      return 'Drink more water';
    }
  }

  Future<void> addNotification() async {
    AwesomeNotifications().removeChannel('scheduled');
    AwesomeNotifications().setChannel(NotificationChannel(
        channelKey: 'scheduled',
        channelName: 'Scheduled Notifications',
        channelDescription: 'Notification channel for basic tests'));
    Box box = Hive.box('notifications');
    await box.put('start', initialWakeUpTime.toString());
    await box.put('end', initialBedTime.toString());
    await box.put('interval', interval);
    notifyListeners();
    int startTime = int.parse(box.get('start').toString().substring(10, 12));
    int endTime = int.parse(box.get('end').toString().substring(10, 12)) == 0
        ? 24 : int.parse(box.get('end').toString().substring(10, 12));
    int intervalTime = await box.get('interval');
    for(var i = 0; i < endTime - startTime + 1; i+=intervalTime){
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: DateTime.now().microsecondsSinceEpoch.remainder(200),
          channelKey: 'scheduled',
          title: '${Emojis.wheater_droplet} Just drink some water ${Emojis.wheater_droplet}',
        ),
        schedule: NotificationCalendar(
            hour: int.parse(box.get('start').toString().substring(10, 12)) + i,
            minute: int.parse(box.get('start').toString().substring(13, 15)),
            second: 0,
            repeats: true
        ),
      );
    }
  }

}