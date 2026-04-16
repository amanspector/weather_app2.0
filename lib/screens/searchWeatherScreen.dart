import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_liquid_glass_plus/flutter_liquid_glass.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:timezone/timezone.dart';
import 'package:weather_app/constants/textConstant.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/provider/current_weather_provider.dart';
import 'package:weather_app/screens/emptyStateScreen.dart';
import 'package:weather_app/screens/widgets/app_tempListCard.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/service/dioService.dart';
import 'package:weather_app/service/notificationService.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Searchweatherscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateSearchweatherscreen();
}

class _StateSearchweatherscreen extends State<Searchweatherscreen> {
  // final apiKey = dotenv.env['API_KEY'];
  // final cityapiKey = dotenv.env['CITY_API_KEY'];
  Weathermodel? cityweathermodel;
  final TextEditingController _citySearch = TextEditingController();
  String? city;

  @override
  Widget build(BuildContext context) {
    cityweathermodel = context.watch<CurrentWeatherProvider>().modelforcity;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: AlignmentGeometry.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.onPrimary,
              Theme.of(context).colorScheme.onSurface,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TypeAheadField<Map<String, dynamic>>(
                debounceDuration: Duration(milliseconds: 600),
                builder: (context, controller, focusNode) {
                  _citySearch.text = controller.text;
                  return TextField(
                    focusNode: focusNode,
                    controller: controller,

                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 5,
                          color: Theme.of(context).colorScheme.onSecondaryFixed,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: Textconstant.txt_entercity,
                    ),
                    style: TextStyle(
                      height: 2,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                },
                emptyBuilder: (context) {
                  if (_citySearch.text.isEmpty || _citySearch.text.length < 2) {
                    return SizedBox.shrink();
                  }

                  return Padding(
                    padding: EdgeInsetsGeometry.all(20),
                    child: Text(
                      "City not found!",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  );
                },
                itemBuilder: (context, value) {
                  return ListTile(
                    title: Text(
                      value['city'],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  );
                },
                onSelected: (value) async {
                  // setState(() {
                  //   _citySearch.text = "${value['city']} ,${value['country']}";
                  // });
                  String city = value['city'];
                  double lat = value['latitude'];
                  double lon = value['longitude'];

                  await context.read<CurrentWeatherProvider>().getCityProvider(
                    city,
                    lat,
                    lon,
                  );

                  Focus.of(context).unfocus();
                  // await Future.delayed(Duration(seconds: 10));
                  final data = await context
                      .read<CurrentWeatherProvider>()
                      .modelforcity;

                  if (data != null) {
                    await Notificationservice.notificaitonplugin.zonedSchedule(
                      id: data.date.hashCode,
                      title: "Recent searched - ${data.city!}",
                      body: "${data.temprature}°C - ${data.weatherCondition}",
                      scheduledDate: tz.TZDateTime.now(
                        tz.local,
                      ).add(Duration(minutes: 1)),
                      notificationDetails: NotificationDetails(
                        android: AndroidNotificationDetails(
                          'weather_id',
                          'weather data',
                          priority: Priority.high,
                          importance: Importance.max,
                        ),
                      ),
                      androidScheduleMode:
                          AndroidScheduleMode.exactAllowWhileIdle,
                    );
                  }
                },
                suggestionsCallback: (search) async {
                  if (search.length < 2) return [];
                  final map1 = await Dioservice().searchCity(search.trim());
                  // final citycountrymap = map1.map(
                  //   (e) => ,
                  // )
                  return map1;
                  //  Dioservice().searchCity(search.trim());
                },
              ),
            ),

            if (_citySearch.text.isEmpty)
              Expanded(child: Emptystatescreen.emptyScreen(context))
            else if (cityweathermodel != null)
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: searchScreenState(cityweathermodel!),
                ),
              )
            else if (context.watch<CurrentWeatherProvider>().isloading_city ==
                true)
              Center(child: CircularProgressIndicator())
            else
              Expanded(child: Emptystatescreen.emptyScreen(context)),
          ],
        ),
      ),
    );
  }

  Widget searchScreenState(Weathermodel cityweathermodel) {
    String mintemp = cityweathermodel.mintemp.toString();
    String maxtemp = cityweathermodel.maxtemp.toString();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          child: Text(
            textAlign: TextAlign.center,
            toBeginningOfSentenceCase(cityweathermodel.city ?? "city"),
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        SizedBox(height: 10),

        Text(
          textAlign: TextAlign.center,
          "${cityweathermodel.temprature}°C",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Min: $mintemp°C",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              "Min : $maxtemp°C",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          textAlign: TextAlign.center,
          cityweathermodel.weatherCondition!,
          style: Theme.of(context).textTheme.displayMedium,
        ),
        SizedBox(height: 10),

        AppTemplistcard(
          listviewlength: cityweathermodel.hourly!.length,
          datalist: cityweathermodel.hourly!,
          isday: false,
        ),

        SizedBox(height: 10),

        LiquidGlassLayer(
          child: LiquidGlass(
            shape: LiquidRoundedRectangle(borderRadius: 40),
            child: SizedBox(
              height: 70,
              width: MediaQuery.sizeOf(context).width * 0.91,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie_json/sunrise.json', height: 60),
                  Text(
                    Textconstant.txt_sunrise,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    Textconstant.txt_colon,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    cityweathermodel.sunrise!,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 10),

        LiquidGlassLayer(
          child: LiquidGlass(
            shape: LiquidRoundedRectangle(borderRadius: 40),
            child: SizedBox(
              height: 70,
              width: MediaQuery.sizeOf(context).width * 0.91,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie_json/sunset.json', height: 60),
                  Text(
                    Textconstant.txt_sunset,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    Textconstant.txt_colon,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  Text(
                    cityweathermodel.sunset!,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),
          ),
        ),

        // AppTemplistcard(
        //   listviewlength: cityweathermodel.daily!.length,
        //   datalist: cityweathermodel.daily!,
        //   isday: true,
        // ),
      ],
    );
  }
}
