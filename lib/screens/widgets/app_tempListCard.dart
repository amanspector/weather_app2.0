import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass_plus/flutter_liquid_glass.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/constants/colorConstant.dart';
import 'package:weather_app/constants/textConstant.dart';
import 'package:weather_app/screens/homeScreen.dart';

class AppTemplistcard extends StatefulWidget {
  int? listviewlength;
  List<dynamic> datalist;
  String? currentDate;
  bool isday;
  AppTemplistcard({
    required this.listviewlength,
    required this.datalist,
    this.currentDate,
    required this.isday,
  });
  @override
  State<StatefulWidget> createState() => _StateAppTemplistcard();
}

class _StateAppTemplistcard extends State<AppTemplistcard> {
  static DateTime today1 = DateTime.now();
  String todaydate = DateFormat('EEEE , d MMMM').format(today1);

  @override
  Widget build(BuildContext context) {
    return LiquidGlassLayer(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: LiquidGlass(
              shape: LiquidRoundedRectangle(borderRadius: 40),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                ),

                height: 250,
                width: MediaQuery.sizeOf(context).width * 0.91,
                child: widget.isday
                    ? Padding(
                        padding: const EdgeInsets.only(left: 140.0, top: 10),
                        child: Text(
                          Textconstant.txt_daily_broadcast,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              Textconstant.txt_24hour_broadcast,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              todaydate,
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          Positioned(
            top: 22,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 10,
              ),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(),
                height: 200,
                width: MediaQuery.sizeOf(context).width * 0.89,
                child: LiquidGlassLayer(
                  settings: LiquidGlassSettings(
                    thickness: 20,
                    blur: 10,
                    glassColor: Color.fromARGB(28, 255, 255, 255),
                  ),
                  child: LiquidGlassBlendGroup(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: widget.datalist.length,
                      itemBuilder: (context, index) {
                        final hour;
                        hour = widget.datalist[index];
                        String dayortime;
                        if (widget.isday == true) {
                          dayortime = hour.day ?? "--";
                        } else {
                          dayortime = hour.date ?? "--";
                        }
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: LiquidGlass.grouped(
                            shape: LiquidRoundedSuperellipse(
                              // side: BorderSide(width: 10),
                              borderRadius: 60,
                            ),
                            child: Container(
                              width: 90,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.15),
                                  // width: 20,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${hour.temp ?? "--"}°",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displaySmall,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 70,
                                      width: 70,
                                      child: Lottie.asset(
                                        Homescreen.getLottieIcon(
                                          hour.icon ?? '01d',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    dayortime,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.displaySmall,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
