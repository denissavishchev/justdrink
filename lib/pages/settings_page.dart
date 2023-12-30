import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:justdrink/providers/water_provider.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../widgets/basic_container_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/icon_svg_widget.dart';
import '../widgets/one_scroll_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBlue,
      body: SafeArea(
        child: Consumer<WaterProvider>(
          builder: (context, water, _){
            Box settings = Hive.box('water_settings');
            return Center(
                child: SizedBox(
                  height: size.height,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.28,
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
                          child: Align(
                            alignment: Alignment.center,
                            child: Text('Water is essential for your body\'s optimal function.'
                                '\nIt regulates temperature, aids digestion, '
                                '\nflushes out toxins, maintains skin health, '
                                '\nand supports overall well-being. '
                                '\nStaying hydrated improves concentration, '
                                '\nboosts energy levels, enhances physical performance. '
                                '\nMake water your go-to choice for a healthier, '
                                '\nmore vibrant you.',
                              style: kOrangeStyle.copyWith(fontSize: 16),
                              textAlign: TextAlign.center,),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BasicContainerWidget(
                              height: size.height * 0.11,
                              width: size.width * 0.74,
                              child: Row(
                                children: [
                                  Text('Weight: ', style: kOrangeStyle.copyWith(fontSize: 18.sp),),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            width: 58,
                                            height: 98,
                                            child: ListWheelScrollView(
                                              controller: FixedExtentScrollController(
                                                  initialItem: settings.get('weight') == null
                                                      ? 0
                                                      : int.parse(settings.get('weight').substring(0, 1))),
                                              onSelectedItemChanged: (index) {
                                                FocusManager.instance.primaryFocus?.unfocus();
                                                water.setTarget(index, 0);
                                              },
                                              physics: const FixedExtentScrollPhysics(),
                                              itemExtent: 58,
                                              children: List.generate(10, (index){
                                                return OneScrollWidget(index: index,);
                                              } ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 58,
                                            height: 98,
                                            child: ListWheelScrollView(
                                              controller: FixedExtentScrollController(
                                                  initialItem: settings.get('weight') == null
                                                      ? 0
                                                      : int.parse(settings.get('weight').substring(1, 2))),
                                              onSelectedItemChanged: (index) {
                                                FocusManager.instance.primaryFocus?.unfocus();
                                                water.setTarget(index, 1);
                                              },
                                              physics: const FixedExtentScrollPhysics(),
                                              itemExtent: 58,
                                              children: List.generate(10, (index){
                                                return OneScrollWidget(index: index,);
                                              }
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 58,
                                            height: 98,
                                            child: ListWheelScrollView(
                                              controller: FixedExtentScrollController(
                                                  initialItem: settings.get('weight') == null
                                                      ? 0
                                                      : int.parse(settings.get('weight').substring(2, 3))),
                                              onSelectedItemChanged: (index) {
                                                FocusManager.instance.primaryFocus?.unfocus();
                                                water.setTarget(index, 2);
                                              },
                                              physics: const FixedExtentScrollPhysics(),
                                              itemExtent: 58,
                                              children: List.generate(10, (index){
                                                return OneScrollWidget(index: index,);
                                              }
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(' kg', style: kOrangeStyle.copyWith(fontSize: 18.sp),),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: ButtonWidget(
                                    child: Text(water.kg ? 'kg' : 'lbs',
                                      style: kOrangeStyle.copyWith(fontSize: 18.sp),),
                                    onTap: () => water.kgLbs()),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BasicContainerWidget(
                              height: size.height * 0.11,
                              width: size.width * 0.45,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${water.initialWakeUpTime.hour < 10
                                      ? '0${water.initialWakeUpTime.hour}'
                                      : '${water.initialWakeUpTime.hour}'}'
                                      ':${water.initialWakeUpTime.minute < 10
                                      ? '0${water.initialWakeUpTime.minute}'
                                      : '${water.initialWakeUpTime.minute}'}',
                                    style: kOrangeStyle. copyWith(fontSize: 18.sp),
                                  ),
                                  ButtonWidget(
                                      child: const IconSvgWidget(icon: 'time',),
                                      onTap: () => water.wakeUpTimePicker(context)),
                                ],
                              ),
                            ),
                            BasicContainerWidget(
                              height: size.height * 0.11,
                              width: size.width * 0.45,
                              right: false,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonWidget(
                                      child: const IconSvgWidget(icon: 'time',),
                                      onTap: () => water.bedTimePicker(context)),
                                  Text('${water.initialBedTime.hour < 10
                                      ? '0${water.initialBedTime.hour}'
                                      : '${water.initialBedTime.hour}'}'
                                      ':${water.initialBedTime.minute < 10
                                      ? '0${water.initialBedTime.minute}'
                                      : '${water.initialBedTime.minute}'}',
                                      style: kOrangeStyle. copyWith(fontSize: 18.sp)
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BasicContainerWidget(
                              height: size.height * 0.11,
                              width: size.width * 0.5,
                              child: Row(
                                children: [
                                  Text('Interval (h): ',
                                    style: kOrangeStyle.copyWith(fontSize: 18.sp),),
                                  SizedBox(
                                      width: 58,
                                      height: 98,
                                      child: ListWheelScrollView(
                                        controller: FixedExtentScrollController(
                                            initialItem: settings.get('interval') == null
                                                ? 0
                                                : settings.get('interval') - 1),
                                        onSelectedItemChanged: (index) {
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          water.setInterval(index + 1);
                                        },
                                        physics: const FixedExtentScrollPhysics(),
                                        itemExtent: 58,
                                        children: List.generate(3, (index){
                                          return OneScrollWidget(index: index + 1,);
                                        } ),
                                      )
                                  ),
                                ],
                              ),
                            ),
                            BasicContainerWidget(
                              right: false,
                              height: size.height * 0.11,
                              width: size.width * 0.32,
                              child: Row(
                                children: [
                                  ButtonWidget(
                                    onTap: () => water.darkMode(),
                                    child: IconSvgWidget(
                                      icon: 'bulb',
                                      color: water.dark ? Colors.black : kOrange,
                                    )),
                                  const Spacer()
                                ],
                              )
                            )
                          ],
                        ),
                        Container(
                          height: size.height * 0.11,
                          width: size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
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
                          child: Row(
                            children: [
                              const Spacer(),
                              ButtonWidget(
                                  child: const IconSvgWidget(icon: 'drop',),
                                  onTap: () {
                                    water.saveSettings(context);
                                    water.addNotification();
                                    }),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ]
                  ),
                )
            );
          },
        ),
      )
    );
  }
}
