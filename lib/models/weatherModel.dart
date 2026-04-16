import 'package:intl/intl.dart';
import 'package:weather_app/models/dailyWeatherModel.dart';
import 'package:weather_app/models/hourlyWeatherModel.dart';

class Weathermodel {
  String? date;
  String? city;
  double? temprature;
  double? mintemp;
  double? maxtemp;
  String? weatherCondition;
  String? icon;
  String? sunrise;
  String? sunset;
  double? uvi;
  String? windspeed;
  String? windspeedString;
  String? pressure;

  List<Hourlyweathermodel>? hourly;
  List<Dailyweathermodel>? daily;

  Weathermodel({
    required this.date,
    required this.city,
    required this.temprature,
    required this.mintemp,
    required this.maxtemp,
    required this.weatherCondition,
    required this.icon,
    required this.uvi,
    required this.windspeed,
    required this.hourly,
    required this.daily,
    required this.windspeedString,
    required this.sunrise,
    required this.sunset,
  });

  factory Weathermodel.fromjson(
    Map<String, dynamic> json,
    String city,
    List<Hourlyweathermodel>? hourly,
    List<Dailyweathermodel>? daily,
    var mintemp,
    var maxtemp,
  ) {
    double wind = (json['wind_speed'] as num).toDouble();
    double uvi = (json['uvi'] as num).toDouble();
    double mintemp1 = (mintemp as num).toDouble();
    double maxtemp1 = (maxtemp as num).toDouble();

    String windString = "";

    if (wind >= 0 && wind < 0.2) {
      windString = "wind_beaufort_0";
    } else if (wind > 0.3 && wind < 1.5) {
      windString = "wind_beaufort_1";
    } else if (wind > 1.6 && wind < 3.3) {
      windString = "wind_beaufort_2";
    } else if (wind > 3.4 && wind < 5.4) {
      windString = "wind_beaufort_3";
    } else if (wind > 5.5 && wind < 7.9) {
      windString = "wind_beaufort_4";
    } else if (wind > 8.0 && wind < 10.7) {
      windString = "wind_beaufort_5";
    } else if (wind > 10.8 && wind < 13.8) {
      windString = "wind_beaufort_6";
    } else if (wind > 13.9 && wind < 17.1) {
      windString = "wind_beaufort_7";
    } else if (wind > 17.2 && wind < 20.7) {
      windString = "wind_beaufort_8";
    } else if (wind > 20.8 && wind < 24.4) {
      windString = "wind_beaufort_9";
    } else if (wind > 24.5 && wind < 28.4) {
      windString = "wind_beaufort_10";
    } else if (wind > 28.5 && wind < 32.6) {
      windString = "wind_beaufort_11";
    } else if (wind > 32.7) {
      windString = "wind_beaufort_12";
    } else {
      windString = "not_available";
    }

    String dtToTemp(int dt, String formattype) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(dt * 1000);
      String temp = DateFormat(formattype).format(date);
      return temp;
    }

    return Weathermodel(
      date: dtToTemp(json['dt'], 'EEEE, MMM d'),
      city: city,
      temprature: (json['temp'] as num).toDouble(),
      weatherCondition: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      uvi: uvi,
      windspeed: json['wind_speed'].toString(),
      hourly: hourly,
      daily: daily,
      windspeedString: windString,
      sunrise: dtToTemp(json['sunrise'], 'h:mm a'),
      sunset: dtToTemp(json['sunset'], 'h:mm a'),
      mintemp: mintemp1,
      maxtemp: maxtemp1,
    );
  }
}
