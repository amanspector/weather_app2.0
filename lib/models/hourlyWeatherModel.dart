import 'package:intl/intl.dart';

class Hourlyweathermodel {
  String? date;
  String? temp;
  String? icon;

  Hourlyweathermodel({
    required this.date,
    required this.temp,
    required this.icon,
  });

  factory Hourlyweathermodel.fromjson(Map<String, dynamic> json) {
    DateTime dateformat = DateTime.fromMillisecondsSinceEpoch(
      (json['dt'] as int) * 1000,
    );

    return Hourlyweathermodel(
      date: DateFormat('h a').format(dateformat),
      temp: (json['temp'] as num).toDouble().toString(),
      icon: json['weather'][0]['icon'],
    );
  }

  Map<String, dynamic> tomap() {
    Map<String, dynamic> data = {};
    data["date"] = date;
    data["temp"] = temp;
    data["icon"] = icon;
    return data;
  }
}
