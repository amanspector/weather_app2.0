import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass_plus/flutter_liquid_glass.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/colorConstant.dart';
import 'package:weather_app/constants/textConstant.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/provider/current_weather_provider.dart';
import 'package:weather_app/screens/widgets/app_tempListCard.dart';
import 'homeScreen.dart';

class Forcastscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StateForcastscreen();
}

class _StateForcastscreen extends State<Forcastscreen> {
  @override
  Widget build(BuildContext context) {
    double aqiValue = context.watch<CurrentWeatherProvider>().aqi!.toDouble();
    String aqiCondition =
        context.watch<CurrentWeatherProvider>().aqi_status ?? "";

    Weathermodel? currentweatherdata = context
        .watch<CurrentWeatherProvider>()
        .model;
    int? uvindex = (currentweatherdata?.uvi! as num).toInt();
    return currentweatherdata == null
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
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
                  SizedBox(height: 50),

                  AppTemplistcard(
                    listviewlength: currentweatherdata.daily!.length,
                    datalist: currentweatherdata.daily!,
                    currentDate: currentweatherdata.date,
                    isday: true,
                  ),
                  SizedBox(height: 10),
                  LiquidGlassLayer(
                    child: LiquidGlass(
                      shape: LiquidRoundedRectangle(borderRadius: 40),
                      child: SizedBox(
                        height: 130,
                        width: MediaQuery.sizeOf(context).width * 0.91,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),

                            Center(
                              child: Text(
                                "${Textconstant.txt_aqi} : $aqiCondition",
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),

                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SfLinearGauge(
                                  animateAxis: true,
                                  minimum: 1,
                                  maximum: 5,
                                  animateRange: true,
                                  animationDuration: 2000,
                                  majorTickStyle: LinearTickStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  markerPointers: [
                                    LinearShapePointer(value: aqiValue),
                                  ],

                                  // barPointers: [
                                  //   LinearBarPointer(
                                  //     enableAnimation: true,
                                  //     value: aqi_value,
                                  //   ),
                                  // ],
                                  ranges: [
                                    LinearGaugeRange(
                                      startValue: 1,
                                      endValue: 1.5,
                                      color: Colorconstant.rangegreencolor,
                                    ),
                                    LinearGaugeRange(
                                      startValue: 1.5,
                                      endValue: 2.5,
                                      color: Colorconstant.rangeyellowcolor,
                                    ),
                                    LinearGaugeRange(
                                      startValue: 2.5,
                                      endValue: 3.5,
                                      color: Colorconstant.rangeorangecolor,
                                    ),
                                    LinearGaugeRange(
                                      startValue: 3.5,
                                      endValue: 4.5,
                                      color: Colorconstant.rangeredcolor,
                                    ),
                                    LinearGaugeRange(
                                      startValue: 4.5,
                                      endValue: 5.5,
                                      color: Colorconstant.rangepurplecolor,
                                    ),
                                  ],

                                  axisLabelStyle: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LiquidGlassLayer(
                        child: LiquidGlass(
                          shape: LiquidRoundedRectangle(borderRadius: 40),
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.20,
                            width: MediaQuery.sizeOf(context).width * 0.40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Textconstant.txt_sunrise,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  // child: Lottie.asset(
                                  //   'assets/lottie_json/wind_beaufort_1.json',
                                  // ),
                                  child: Lottie.asset(
                                    "assets/lottie_json/sunrise.json",
                                  ),
                                ),
                                Text(
                                  currentweatherdata.sunrise!,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      LiquidGlassLayer(
                        child: LiquidGlass(
                          shape: LiquidRoundedRectangle(borderRadius: 40),
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.20,
                            width: MediaQuery.sizeOf(context).width * 0.40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Textconstant.txt_sunset,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),

                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Lottie.asset(
                                    "assets/lottie_json/sunset.json",
                                  ),
                                ),
                                Text(
                                  currentweatherdata.sunset!,
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LiquidGlassLayer(
                        child: LiquidGlass(
                          shape: LiquidRoundedRectangle(borderRadius: 40),
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.20,
                            width: MediaQuery.sizeOf(context).width * 0.40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Textconstant.txt_windspeed,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                                Text(
                                  Textconstant.txt_beaufortScale,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  // child: Lottie.asset(
                                  //   'assets/lottie_json/wind_beaufort_1.json',
                                  // ),
                                  child: Lottie.asset(
                                    'assets/lottie_json/${currentweatherdata.windspeedString!}.json',
                                  ),
                                ),
                                Text(
                                  "${currentweatherdata.windspeed!}m/s",
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      LiquidGlassLayer(
                        child: LiquidGlass(
                          shape: LiquidRoundedRectangle(borderRadius: 40),
                          child: SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.20,
                            width: MediaQuery.sizeOf(context).width * 0.40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Textconstant.txt_uvindex,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displaySmall,
                                ),

                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  // child: Text(currentweatherdata.uvi!),
                                  child: Lottie.asset(
                                    Homescreen.getLottieIcon(
                                      uvindex.toString(),
                                    ),
                                  ),
                                ),
                                Text(
                                  currentweatherdata.uvi!.toString(),
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
