import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/constants/colorConstant.dart';
import 'package:weather_app/constants/textConstant.dart';
import 'package:weather_app/screens/homeScreen.dart';
import 'package:permission_handler/permission_handler.dart';

class Onboardscreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnboardscreenState();
}

class _OnboardscreenState extends State<Onboardscreen> {
  bool isloading = false;
  Future<Position?> _getLatLong() async {
    bool serviceEnable;
    LocationPermission permission;

    var notificatoinStatus = await Permission.notification.status;
    if (notificatoinStatus.isRestricted) {
      await Permission.notification.request();
      if (Permission.notification.isDenied == true) {
        await Permission.notification.request();
        if (Permission.notification.isPermanentlyDenied == true) {
          await Permission.notification.request();
        }
      }
    }

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      await show_dialog();
      return null;
    }
    // permission = await Geolocator.requestPermission();

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      await show_dialog();
      return null;
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(Textconstant.txt_locationdisabled)),
        );
        return null;
      }
      if (permission == LocationPermission.deniedForever) {
        await show_dialog();
        return null;
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> show_dialog() async {
    bool serviceEnable = await Geolocator.isLocationServiceEnabled();

    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            !serviceEnable
                ? Textconstant.txt_gotosetting
                : Textconstant.txt_gotoappsetting,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (!serviceEnable) {
                  await Geolocator.openLocationSettings();
                } else {
                  await Geolocator.openAppSettings();
                }

                setState(() {
                  isloading = false;
                });
                Navigator.pop(context);
              },
              child: Text(
                Textconstant.txt_yes,
                style: TextStyle(color: Colorconstant.redcolor, fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  isloading = false;
                });

                return null;
              },
              child: Text(
                Textconstant.txt_no,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void redirectToHomeScreen() async {
    setState(() {
      isloading = true;
    });
    final postion = await _getLatLong();

    if (postion == null) {
      print("position is null !");
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            Homescreen(lat: postion.latitude, long: postion.longitude),
      ),
    );

    // await FlutterLocalNotificationsPlugin().show(
    //   id: 0,
    //   title: "Test Notification",
    //   body: "If you see this → plugin works",
    //   notificationDetails: const NotificationDetails(
    //     android: AndroidNotificationDetails(
    //       'test_channel',
    //       'Test Channel',
    //       importance: Importance.max,
    //       priority: Priority.high,
    //     ),
    //   ),
    // );

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.onPrimary,
              Theme.of(context).colorScheme.onSurface,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 328,
              child: Text(
                textAlign: TextAlign.center,
                maxLines: 2,
                Textconstant.txt_discoverweather,
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),

            // SizedBox(height: 50),
            Lottie.asset(
              'assets/lottie_json/partly_cloudy_day_drizzle.json',
              height: 400,
              width: 400,
              repeat: true,
            ),
            SizedBox(
              width: 270,
              child: Text(
                textAlign: TextAlign.center,
                maxLines: 2,
                Textconstant.txt_gettoknowtext,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 45),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colorconstant.yellowcolor,
                ),
                onPressed: () {
                  if (isloading == false) {
                    redirectToHomeScreen();
                  }
                },
                child: Center(
                  child: isloading == false
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            style: Theme.of(context).textTheme.displayMedium,
                            Textconstant.txt_getstarted,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: CircularProgressIndicator(),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
