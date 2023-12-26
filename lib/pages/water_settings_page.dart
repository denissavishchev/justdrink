import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:justdrink/pages/water_page.dart';
import 'package:justdrink/providers/water_provider.dart';
import 'package:provider/provider.dart';

class WaterSettingsPage extends StatelessWidget {
  const WaterSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<WaterProvider>(
        builder: (context, water, _){
          Box settings = Hive.box('water_settings');
          return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      child: Text('Back'),
                      onPressed: () => Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) =>
                          const WaterPage())),
                    ),
                    Row(
                      children: [
                        Text(' Weight: '),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 192,
                              height: 104,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        blurRadius: 3,
                                        offset: const Offset(0, 2)
                                    ),
                                  ]
                              ),
                            ),
                            Container(
                                width: 188,
                                height: 98,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                                  gradient: LinearGradient(
                                      colors: [
                                        const Color(0xffbebebc).withOpacity(0.5),
                                        const Color(0xff1a1a18).withOpacity(0.8),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      stops: const [0, 0.75]),
                                ),
                                child: Row(
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
                                          return Container(
                                            margin: EdgeInsets.symmetric(vertical: 4),
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff91918f),
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(25)),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Colors.red,
                                                      blurRadius: 3,
                                                      offset: Offset(0, 2)),
                                                  BoxShadow(
                                                      color: Color(0xff5e5e5c),
                                                      blurRadius: 1,
                                                      offset: Offset(0, -1)),
                                                ]),
                                            child: Center(child: Text('$index')),
                                          );
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
                                          return Container(
                                            margin: EdgeInsets.symmetric(vertical: 4),
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff91918f),
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(25)),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Colors.black,
                                                      blurRadius: 3,
                                                      offset: Offset(0, 2)),
                                                  BoxShadow(
                                                      color: Color(0xff5e5e5c),
                                                      blurRadius: 1,
                                                      offset: Offset(0, -1)),
                                                ]),
                                            child: Center(child: Text('$index')),
                                          );
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
                                          return Container(
                                            margin: EdgeInsets.symmetric(vertical: 4),
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff91918f),
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(25)),
                                                boxShadow: const [
                                                  BoxShadow(
                                                      color: Colors.black,
                                                      blurRadius: 3,
                                                      offset: Offset(0, 2)),
                                                  BoxShadow(
                                                      color: Color(0xff5e5e5c),
                                                      blurRadius: 1,
                                                      offset: Offset(0, -1)),
                                                ]),
                                            child: Center(child: Text('$index')),
                                          );
                                        }
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('${water.initialWakeUpTime.hour < 10
                            ? '0${water.initialWakeUpTime.hour}'
                            : '${water.initialWakeUpTime.hour}'}'
                            ':${water.initialWakeUpTime.minute < 10
                            ? '0${water.initialWakeUpTime.minute}'
                            : '${water.initialWakeUpTime.minute}'}'
                        ),
                        Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0xffbebebc).withOpacity(0.5),
                                    const Color(0xff1a1a18).withOpacity(0.8),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: const [0, 0.75]),
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () => water.wakeUpTimePicker(context),
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff91918f),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black,
                                            // spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0, 2)),
                                        BoxShadow(
                                            color: Color(0xff5e5e5c),
                                            // spreadRadius: 2,
                                            blurRadius: 1,
                                            offset: Offset(0, -1)),
                                      ]),
                                  child: Icon(Icons.timelapse_rounded),
                                ),
                              ),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Text('${water.initialBedTime.hour < 10
                            ? '0${water.initialBedTime.hour}'
                            : '${water.initialBedTime.hour}'}'
                            ':${water.initialBedTime.minute < 10
                            ? '0${water.initialBedTime.minute}'
                            : '${water.initialBedTime.minute}'}'
                        ),
                        Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0xffbebebc).withOpacity(0.5),
                                    const Color(0xff1a1a18).withOpacity(0.8),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: const [0, 0.75]),
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () => water.bedTimePicker(context),
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: const Color(0xff91918f),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black,
                                            // spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0, 2)),
                                        BoxShadow(
                                            color: Color(0xff5e5e5c),
                                            // spreadRadius: 2,
                                            blurRadius: 1,
                                            offset: Offset(0, -1)),
                                      ]),
                                  child: Icon(Icons.timelapse_rounded),
                                ),
                              ),
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Inreval'),
                        Container(
                            width: 58,
                            height: 98,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0xffbebebc).withOpacity(0.5),
                                    const Color(0xff1a1a18).withOpacity(0.8),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: const [0, 0.75]),
                            ),
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
                              children: List.generate(5, (index){
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff91918f),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(25)),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black,
                                            blurRadius: 3,
                                            offset: Offset(0, 2)),
                                        BoxShadow(
                                            color: Color(0xff5e5e5c),
                                            blurRadius: 1,
                                            offset: Offset(0, -1)),
                                      ]),
                                  child: Center(child: Text('${index + 1}')),
                                );
                              } ),
                            )
                        ),
                      ],
                    ),
                    ElevatedButton(
                      child: Text('Save'),
                      onPressed: () => water.saveSettings(context),
                    ),
                  ]
              )
          );
        },
      )
    );
  }
}
