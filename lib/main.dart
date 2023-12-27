import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:justdrink/pages/settings_page.dart';
import 'package:justdrink/pages/water_page.dart';
import 'package:justdrink/providers/water_provider.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'models/buttons_model.dart';
import 'models/water_daily_model.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WaterDailyModelAdapter());
  Hive.registerAdapter(ButtonsModelAdapter());
  await Hive.openBox<WaterDailyModel>('water_daily');
  await Hive.openBox<ButtonsModel>('buttons');
  await Hive.openBox('water_settings');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<WaterProvider>(create: (_) => WaterProvider()),
        ],
        builder: (context, child) {
          Box settings = Hive.box('water_settings');
            return ScreenUtilInit(
              designSize: const Size(360, 780),
              builder: (_, child) => MaterialApp(
                theme: pickerTheme,
                debugShowCheckedModeBanner: false,
                home: settings.isEmpty ? const SettingsPage() : const WaterPage(),
              ),
            );
          }
    );
  }
}

