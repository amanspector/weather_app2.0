import 'package:intl/intl.dart';

class Dailyweathermodel {
  String? day;
  String? temp;
  String? icon;
  Dailyweathermodel({
    required this.day,
    required this.temp,
    required this.icon,
  });

  factory Dailyweathermodel.fromjson(Map<String, dynamic> json) {
    // String avg = (((json['temp']['min'] + json['temp']['max']) / 2))..toString();
    String avg =
        (((json['temp']['min'] as num).round() +
                    (json['temp']['max'] as num).round()) /
                2)
            .toString();
    DateTime day = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000);
    String dayname = DateFormat('EEEE').format(day);
    return Dailyweathermodel(
      day: dayname,
      temp: avg,
      icon: json['weather'][0]['icon'],
    );
  }
}
