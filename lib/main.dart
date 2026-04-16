import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/themeConstant.dart';
import 'package:weather_app/provider/current_weather_provider.dart';
import 'package:weather_app/provider/theme_provider.dart';
import 'package:weather_app/screens/homeScreen.dart';
import 'package:weather_app/screens/onboardScreen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:weather_app/service/notificationService.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  tz.initializeTimeZones();
  await Notificationservice.init();
  await Workmanager().initialize(callbackDispatcher);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentWeatherProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather app',
      theme: Themeconstant.lightthemedata,
      darkTheme: Themeconstant.darkthemedata,
      themeMode: theme.themeMode,
      home: Onboardscreen(),
    );
  }
}
