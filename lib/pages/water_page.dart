import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:justdrink/providers/water_provider.dart';
import 'package:justdrink/widgets/basic_container_widget.dart';
import 'package:justdrink/widgets/one_scroll_widget.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../models/boxes.dart';
import '../models/buttons_model.dart';
import '../models/water_daily_model.dart';
import '../widgets/button_widget.dart';
import '../widgets/icon_svg_widget.dart';
import '../widgets/progress_widget.dart';
import '../widgets/water_chart_widget.dart';

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
                      water.waterDaily = daily;
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
                                    const SizedBox(height: 15,),
                                    BasicContainerWidget(
                                      height: size.height * 0.14,
                                      width: size.width * 0.65,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ButtonWidget(
                                              child: const IconSvgWidget(icon: 'gear'),
                                              onTap: () => water.toSettingsPage(context, settings)),
                                          Text('Just \ndrink',
                                            style: kOrangeStyle.copyWith(fontSize: 36),
                                            textAlign: TextAlign.center,),
                                          const SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
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
                                            child: Text('Custom',
                                              style: kOrangeStyle,),
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
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      const IconSvgWidget(icon: 'drop', color: kBlue, padding: 10,),
                                                      Text('${buttons[index].buttons}',
                                                        style: kOrangeStyle.copyWith(fontSize: 16),),
                                                    ],
                                                  ),
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
                          const SizedBox(height: 24,),
                          Container(
                            height: size.height * 0.3,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: kBlue,
                              border: Border.all(width: 0.5, color: kOrange),
                              boxShadow: [
                                BoxShadow(
                                  color: kGrey.withOpacity(0.8),
                                  spreadRadius: 4,
                                  blurRadius: 8,
                                )
                              ],
                            ),
                            child: daily.isEmpty
                                  ? Align(
                                    alignment: Alignment.center,
                                    child: Text('Boost your energy, revitalize your body, '
                                        '\nand enhance your well-being with a simple change: '
                                        '\ndrink more water. Stay hydrated and feel the difference!',
                                    style: kOrangeStyle.copyWith(fontSize: 16),
                                    textAlign: TextAlign.center,),
                                    )
                                  : WaterChartWidget(daily: daily,),
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              BasicContainerWidget(
                                  height: size.height * 0.075,
                                  width: size.width * 0.8,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Spacer(),
                                      Text(water.description(), 
                                          style: kOrangeStyle.copyWith(fontSize: 22)),
                                      const Spacer(),
                                      OneScrollWidget(index: int.parse(water.totalHydration())),
                                    ],
                                  )
                              ),
                              const Spacer(),
                            ],
                          ),
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


