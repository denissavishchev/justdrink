import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:justdrink/pages/water_settings_page.dart';
import 'package:justdrink/providers/water_provider.dart';
import 'package:provider/provider.dart';

import '../models/boxes.dart';
import '../models/water_daily_model.dart';

class WaterPage extends StatelessWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<WaterProvider>(
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
                return Center(
                  child: Container(
                    width: 300,
                    height: 600,
                    color: Colors.red,
                    child: Column(
                      children: [
                        ElevatedButton(
                            onPressed: () => Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) =>
                                const WaterSettingsPage())),
                            child: Text('Add')),
                        Text('Weight ${settings.get('weight')}'),
                        Text('Targer ${settings.get('target')}'),
                        Text('Up ${settings.get('wake')}'),
                        Text('Down ${settings.get('bed')}'),
                        Text('Interval ${settings.get('interval')}'),
                        const SizedBox(height: 20,),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 235,
                              height: 235,
                              child: CircularProgressIndicator(
                                value: water.percent / 100,
                                backgroundColor: Colors.deepOrange,
                                strokeWidth: 20,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('${daily.last.percentMl} %'),
                            Text('${daily.last.portionMl} / ${water.target}'),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        ElevatedButton(
                            onPressed: () => water.addPortionToBase(
                                100, box,
                                daily.isNotEmpty
                                    ? daily.last.dateMl.toString()
                                    : DateTime.now().day.toString()),
                            child: Text('Add 100')),
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
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
