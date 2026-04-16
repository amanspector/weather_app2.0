import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/models/dailyWeatherModel.dart';
import 'package:weather_app/models/hourlyWeatherModel.dart';
import 'package:weather_app/models/weatherModel.dart';

// final apiKey = dotenv.env['API_KEY'];

class Dioservice {
  final Dio dio = Dio();
  Future<Weathermodel?> getRequestDio(
    double lat,
    double long,
    String? cityname,
  ) async {
    final apiKey = dotenv.env['API_KEY'];
    String? city;
    final apirequest = Dio(
      BaseOptions(
        baseUrl: "https://api.openweathermap.org/data/3.0/",
        connectTimeout: Duration(seconds: 10),
      ),
    );

    try {
      final res = await apirequest.get(
        'onecall?lat=$lat&lon=$long&units=metric&exclude=minutely&appid=$apiKey',
      );

      final result = res.data;

      if (cityname != null) {
        city = cityname;
      }

      if (cityname == null) {
        List<Placemark> cityList = await placemarkFromCoordinates(lat, long);
        city = cityList.first.locality;
      }
      final current = result['current'];
      List<dynamic> hourly1 = result['hourly'];
      List<dynamic> daily1 = result['daily'];
      var mintemp = result['daily'][0]['temp']['min'];
      var maxtemp = result['daily'][0]['temp']['max'];
      final hourly = hourly1
          .take(25)
          .where(
            (element) =>
                element['dt'] >
                DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000,
          )
          .map((e) => Hourlyweathermodel.fromjson(e))
          .toList();

      final daily = daily1.map((e) => Dailyweathermodel.fromjson(e)).toList();

      print("---------------$current");
      print(city);

      return Weathermodel.fromjson(
        current,
        city!,
        hourly,
        daily,
        mintemp,
        maxtemp,
      );
    } catch (e) {
      print("Current weather error----------------------$e");
    }
  }

  Future getAQI(double lat, double long) async {
    final apiKey = dotenv.env['API_KEY'];
    final api_req_aqi = Dio(
      BaseOptions(
        baseUrl: "http://api.openweathermap.org/data/2.5/",
        connectTimeout: Duration(seconds: 10),
      ),
    );

    try {
      final res_aqi = await api_req_aqi.get(
        'air_pollution?lat=$lat&lon=$long&appid=$apiKey',
      );

      final aqi_data = res_aqi.data;
      int aqi = aqi_data['list'][0]['main']['aqi'];
      return aqi;
    } catch (e) {
      print("AQI Error----------------------$e");
    }
  }

  Future<Weathermodel?> getCityData(String city, double lat, double lon) async {
    try {
      return await getRequestDio(lat, lon, city);
    } catch (e) {
      print("----------------$e");
    }
  }

  Future<List<Map<String, dynamic>>> searchCity(String query) async {
    final cityapiKey = dotenv.env['CITY_API_KEY'];
    try {
      final res = await Dio().get(
        "https://wft-geo-db.p.rapidapi.com/v1/geo/cities",
        queryParameters: {"namePrefix": query},
        options: Options(
          headers: {
            "x-rapidapi-key": "$cityapiKey",
            "x-rapidapi-host": "wft-geo-db.p.rapidapi.com",
          },
        ),
      );

      // final res = await Dio().get(
      //   'http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=5&appid=$apiKey',
      // );

      print("----data------${res.data['data']}");
      // "${e['name'].toString().trim()},  ${e['country']} ,${e['latitude']} , ${e['longitude']}",

      return (res.data['data'] as List<dynamic>)
          .map(
            (e) => {
              "city": '${e['name'].toString().trim()} , ${e['country']}',
              "latitude": e['latitude'],
              "longitude": e['longitude'],
            },
          )
          .toList();
    } catch (e) {
      print("----------------error---------$e");
    }

    return [
      {"": ""},
    ];
  }
}
