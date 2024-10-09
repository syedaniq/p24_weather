import 'package:flutter/material.dart';
import 'weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService weatherService = WeatherService();
  String _description = '';
  double _temperature = 0.0;
  bool _loading = false;

  String get description => _description;
  double get temperature => _temperature;
  bool get loading => _loading;

  Future<void> fetchWeather(String city) async {
    _loading = true;
    notifyListeners();

    try {
      final weatherData = await weatherService.fetchData(city);
      _description = weatherData['description'];
      _temperature = weatherData['temperature'] - 273.15;
    } catch (e) {
      debugPrint("Error fetching weather data: $e");
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
