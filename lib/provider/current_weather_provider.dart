import 'package:flutter/material.dart';
import 'package:weather_app/models/weatherModel.dart';
import 'package:weather_app/service/dioService.dart';

class CurrentWeatherProvider extends ChangeNotifier {
  Dioservice service = Dioservice();
  Weathermodel? _model;
  Weathermodel? _modelforcity;
  int? aqi;
  Weathermodel? get model => _model;
  Weathermodel? get modelforcity => _modelforcity;
  bool isloading = false;
  bool isloading_city = false;
  String? aqi_status;

  Future<void> getprovider(double lat, double long) async {
    isloading = true;
    notifyListeners();
    _model = await service.getRequestDio(lat, long, null);
    aqi = await service.getAQI(lat, long);
    switch (aqi) {
      case 1:
        aqi_status = "Good";
        break;
      case 2:
        aqi_status = "Fair";
        break;
      case 3:
        aqi_status = "Modrate";
        break;
      case 4:
        aqi_status = "Poor";
        break;
      case 5:
        aqi_status = "Very Poor";
        break;
    }
    notifyListeners();

    isloading = false;
    notifyListeners();
  }

  Future<void> getCityProvider(String cityname, double lat, double lon) async {
    isloading_city = true;
    notifyListeners();

    _modelforcity = await service.getCityData(cityname, lat, lon);
    notifyListeners();

    isloading_city = false;
    notifyListeners();
  }
}
