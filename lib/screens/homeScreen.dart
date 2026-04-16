import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:glass_liquid_navbar/glass_liquid_navbar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/constants/colorConstant.dart';
import 'package:weather_app/constants/icontojsonData.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/provider/current_weather_provider.dart';
import 'package:weather_app/provider/theme_provider.dart';
import 'package:weather_app/screens/forcastScreen.dart';
import 'package:weather_app/screens/searchWeatherScreen.dart';
import 'package:weather_app/screens/widgets/app_tempListCard.dart';
import 'package:weather_app/service/dioService.dart';
import 'package:weather_app/service/notificationService.dart';
import 'package:workmanager/workmanager.dart';

class Homescreen extends StatefulWidget {
  double? lat;
  double? long;
  Homescreen({required this.lat, required this.long});

  static String getLottieIcon(String iconcode) {
    return (Icontojsondata.icontoanimation[iconcode] ??
        "assets/lottie_json/not_available.json");
  }

  @override
  State<StatefulWidget> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isDarkMode = false;
  bool isRegistred = false;

  @override
  void initState() {
    super.initState();
    workmanager_register();
  }

  Future<void> workmanager_register() async {
    if (isRegistred) return;

    isRegistred = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final pro = Provider.of<CurrentWeatherProvider>(context, listen: false);

      await pro.getprovider(widget.lat!, widget.long!);
      if (pro.model == null) return;
      await Workmanager().cancelByUniqueName("temp_id");
      await Workmanager().registerOneOffTask(
        "temp_id",
        "weathertask",
        // frequency: Duration(minutes: 15),
        initialDelay: Duration(seconds: 15),
        inputData: {
          "lat": widget.lat,
          "long": widget.long,
          "city": pro.model!.city,
        },
      );
      print(
        "--------------------------------------------------------------init in home screen",
      );
    });
  }

  int bottomnavindex = 0;
  @override
  Widget build(BuildContext context) {
    Weathermodel? currentweatherdata = context
        .watch<CurrentWeatherProvider>()
        .model;
    return currentweatherdata == null
        ? Container(
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
            child: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            body: IndexedStack(
              index: bottomnavindex,
              children: [
                Stack(
                  children: [
                    currentScreen(currentweatherdata),
                    Positioned(
                      bottom: 100,
                      // child: _customCard(currentweatherdata),
                      child: AppTemplistcard(
                        listviewlength: currentweatherdata.hourly!.length,
                        datalist: currentweatherdata.hourly!,
                        currentDate: currentweatherdata.date!,
                        isday: false,
                      ),
                    ),

                    Positioned(
                      right: 30,
                      top: 60,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        // transitionBuilder: (child, anim) =>
                        //     ScaleTransition(scale: anim, child: child),
                        child: isDarkMode
                            ? SizedBox(
                                height: 40,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.nightlight_round,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  key: ValueKey('dark'),
                                  onPressed: () {
                                    setState(() {
                                      isDarkMode = !isDarkMode;
                                    });
                                    context.read<ThemeProvider>().toggleTheme();
                                  },
                                ),
                              )
                            : SizedBox(
                                height: 40,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.wb_sunny,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                  key: ValueKey('light'),
                                  onPressed: () {
                                    setState(() {
                                      isDarkMode = !isDarkMode;
                                    });
                                    context.read<ThemeProvider>().toggleTheme();
                                  },
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                Forcastscreen(),
                Searchweatherscreen(),
              ],
            ),
            bottomNavigationBar: LiquidGlassNavbar(
              theme: LiquidGlassTheme.dark(),
              showLabels: false,
              items: [
                LiquidNavItem(label: "home", icon: Icons.home),
                LiquidNavItem(label: "forcast", icon: Icons.area_chart_sharp),
                LiquidNavItem(label: "search", icon: Icons.search),
              ],
              currentIndex: bottomnavindex,
              onTap: (value) => {
                setState(() {
                  bottomnavindex = value;
                }),
              },
            ),
          );
  }

  Widget currentScreen(Weathermodel currentmodel) {
    return Container(
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
          SizedBox(height: MediaQuery.heightOf(context) * 0.08),
          SizedBox(
            width: MediaQuery.widthOf(context) * 0.60,
            child: Text(
              textAlign: TextAlign.center,
              currentmodel.city ?? "--",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              textAlign: TextAlign.center,
              "${currentmodel.temprature}°",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Min: ${currentmodel.mintemp}°C",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "Max: ${currentmodel.maxtemp}°C",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            textAlign: TextAlign.center,
            currentmodel.weatherCondition!,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Container(
            height: 300,
            width: MediaQuery.widthOf(context),
            child: Lottie.asset(Homescreen.getLottieIcon(currentmodel.icon!)),
          ),
        ],
      ),
    );
  }
}
