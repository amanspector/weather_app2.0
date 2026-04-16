import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/service/dioService.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
Future<void> callbackDispatcher() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  await dotenv.load(fileName: ".env");

  Workmanager().executeTask((taskName, inputData) async {
    print(
      "-----------------------------------------------------------------------Task started : $taskName",
    );
    if (taskName == "weathertask") {
      if (inputData == null) return Future.value(false);
      final plugin = FlutterLocalNotificationsPlugin();
      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      const setting = InitializationSettings(android: android);
      await plugin.initialize(settings: setting);
      tz.initializeTimeZones();

      print("Executed at : ${DateTime.now()}");

      final androidresolve = plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      final channel = AndroidNotificationChannel(
        'workmanager_id',
        'workmanager_channelName',
        importance: Importance.max,
      );

      await androidresolve?.createNotificationChannel(channel);

      try {
        final lat = (inputData!['lat'] as num).toDouble();
        final long = (inputData['long'] as num).toDouble();
        String city = inputData['city'].toString();
        Weathermodel? model = await Dioservice().getRequestDio(lat, long, city);
        print(
          "-----------------------------------------------------------------------City Fetched : $city",
        );

        if (model != null) {
          String modelcity = city;
          String modeltemp = model.temprature!.toString();
          String modelcondition = model.weatherCondition!;

          // ------------------plugin show------------------------

          await plugin.show(
            id: DateTime.now().microsecondsSinceEpoch.hashCode,
            // id: 1,
            title: modelcity,
            body: "$modeltemp°C - $modelcondition",
            notificationDetails: NotificationDetails(
              android: AndroidNotificationDetails(
                'workmanager_id',
                'workmanager_channelName',
                priority: Priority.high,
                importance: Importance.max,
              ),
            ),
          );
        }
        print(
          "-----------------------------------------------------------------------Notificatoin sent",
        );
      } catch (e) {
        print(
          "-----------------------------------------------------------------------Error : $e",
        );
      }
    }

    return Future.value(true);
  });
  print(
    "--------------------------------------------------------------callbackDispatcher",
  );
}

class Notificationservice {
  static final FlutterLocalNotificationsPlugin notificaitonplugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> init() async {
    await notificaitonplugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const setting = InitializationSettings(android: android);
    await notificaitonplugin.initialize(settings: setting);
    tz.initializeTimeZones();
    // final timezone = await FlutterTimezone.getLocalTimezone();
    // tz.setLocalLocation(tz.getLocation(timezone.identifier));
  }

  static Future<void> scheduleDailyNotification(
    int id,
    String title,
    String body,
  ) async {
    await notificaitonplugin.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          'weather_id',
          'weather data',
          priority: Priority.high,
          importance: Importance.max,
        ),
      ),
    );
  }

  // static tz.TZDateTime _Dailynotification() {
  //   final now = tz.TZDateTime.now(tz.local);

  //   final schedule = tz.TZDateTime(
  //     tz.local,
  //     now.year,
  //     now.month,
  //     now.day,
  //     now.hour,
  //     now.minute,
  //     now.second + now.add(Duration(seconds: 5)),
  //   );

  //   return now.add(Duration(seconds: 10));
  // }
}
