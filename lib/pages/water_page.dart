import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:justdrink/pages/water_settings_page.dart';
import 'package:justdrink/providers/water_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/boxes.dart';
import '../models/buttons_model.dart';
import '../models/water_daily_model.dart';
import '../widgets/button_widget.dart';
import '../widgets/icon_svg_widget.dart';
import '../widgets/progress_widget.dart';

class WaterPage extends StatelessWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlue,
        body: ValueListenableBuilder(
          valueListenable: Boxes.addButtonToBase().listenable(),
          builder: (context, buttonsBox, _){
            final buttons = buttonsBox.values.toList().cast<ButtonsModel>();
            return Consumer<WaterProvider>(
              builder: (context, water, _){
                Box settings = Hive.box('water_settings');
                water.target = settings.get('target') ?? 0;
                return ValueListenableBuilder(
                    valueListenable: Boxes.addWaterDailyToBase().listenable(),
                    builder: (context, box, _){
                      final daily = box.values.toList().cast<WaterDailyModel>();
                      if(daily.isNotEmpty && daily.last.dateMl != DateTime.now().day.toString()){
                        water.water = 0;
                        water.percent = 0;
                      }else if(daily.isNotEmpty){
                        water.water = daily.last.portionMl;
                        water.percent = daily.last.percentMl.toDouble();
                      }else{
                        water.water = 0;
                        water.percent = 0;
                      }
                      return Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: size.width * 0.7,
                                height: size.height * 0.5,
                                color: kBlue,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 260,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ButtonWidget(
                                              child: const IconSvgWidget(icon: 'gear'),
                                              onTap: (){
                                                water.target = settings.get('target') ?? 0;
                                                water.weight = settings.get('weight') ?? '000';
                                                water.initialWakeUpTime = settings.get('wake') == null
                                                    ? const TimeOfDay(hour: 8, minute: 00)
                                                    : TimeOfDay(hour: int.parse(settings.get('wake').split(":")[0]),
                                                    minute: int.parse(settings.get('wake').split(":")[1]));
                                                water.initialBedTime = settings.get('bed') == null
                                                    ? const TimeOfDay(hour: 22, minute: 00)
                                                    : TimeOfDay(hour: int.parse(settings.get('bed').split(":")[0]),
                                                    minute: int.parse(settings.get('bed').split(":")[1]));
                                                Navigator.pushReplacement(context,
                                                    MaterialPageRoute(builder: (context) =>
                                                    const WaterSettingsPage()));
                                              }),
                                        ],
                                      ),
                                    ),
                                    ProgressWidget(daily: daily),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 12),
                                  height: size.height * 0.5,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      color: kBlue,
                                      border: Border.all(width: 0.5, color: kOrange),
                                      boxShadow: [
                                        BoxShadow(
                                            color: kGrey.withOpacity(0.8),
                                            spreadRadius: 4,
                                            blurRadius: 12,
                                            offset: const Offset(0, 8)
                                        )
                                      ],
                                      borderRadius: const BorderRadius.vertical(
                                          bottom: Radius.circular(130))
                                  ),
                                  child: SingleChildScrollView(
                                    physics: const ScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      children: [
                                        ButtonWidget(
                                            child: const Text('custom'),
                                            onTap: () => water.createMl(
                                                context, false, box,
                                                daily.isNotEmpty
                                                    ? daily.last.dateMl.toString()
                                                    :DateTime.now().day.toString())
                                        ),
                                        ListView.builder(
                                            physics: const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: buttons.length,
                                            itemBuilder: (context, index){
                                              return Padding(
                                                padding: const EdgeInsets.only(right: 4),
                                                child: ButtonWidget(
                                                  onLongPress: () {
                                                    water.deleteMl(index, context, buttonsBox);
                                                  },
                                                  onTap: () => water.addPortionToBase(
                                                      buttons[index].buttons, box,
                                                      daily.isNotEmpty
                                                          ? daily.last.dateMl.toString()
                                                          : DateTime.now().day.toString()),
                                                  child: Text('${buttons[index].buttons}'),
                                                ),
                                              );
                                            }
                                        ),
                                        ButtonWidget(
                                          child: const IconSvgWidget(icon: 'add'),
                                          onTap: () => water.createMl(
                                              context, true, box,
                                              daily.isNotEmpty
                                                  ? daily.last.dateMl.toString()
                                                  :DateTime.now().day.toString()),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 80,
                            width: 250,
                            child: ListView.builder(
                                itemCount: daily.length,
                                itemBuilder: (context, index){
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Date ${DateFormat('yyyy-MM-dd').format(DateTime.parse(daily[index].dateTime))}'),
                                      Text('Portion ${daily[index].portionMl}'),
                                      Text('${daily[index].percentMl}%'),
                                    ],
                                  );
                                }),
                          )
                        ],
                      );
                    });
              },
            );
          },
        ),
      ),
    );
  }
}


