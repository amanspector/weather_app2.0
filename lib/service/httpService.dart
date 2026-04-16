import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weatherModel.dart';

final api_key = dotenv.env['API_KEY'];

class Httpservice {
  Future<Weathermodel?> getRequest(double lat, double long) async {
    dynamic finalresult;
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$long&exclude=minutely&appid=${api_key}',
        ),
      );

      if (res.statusCode == 200) {
        finalresult = jsonDecode(res.body);
      } else {
        print('Server Error: ${res.statusCode}');
      }

      // Currentweathermodel(
      //   city: finalresult['timezone'],
      //   temprature: finalresult['current']['temp'],
      //   weatherCondition: finalresult['current']['weather']['main'],
      //   icon: finalresult['current']['weather']['icon'],
      // );
      print(finalresult.runtimeType);
      final currentweather = finalresult['current'];

      print(currentweather);
      // return Weathermodel.fromjson(currentweather, finalresult['timezone']);
    } catch (e) {
      print(e);
    }
  }
}
