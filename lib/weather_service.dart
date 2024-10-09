import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<Map<String, dynamic>> fetchData(String cityName) async {
    final uri = Uri.parse(baseUrl).replace(queryParameters: {
      'q': cityName,
      'appid': dotenv.env['API_KEY'],
    });

    print(uri);
    final response = await http.get(Uri.parse(uri.toString()));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      return {
        'description': data['weather'][0]['description'],
        'temperature': data['main']['temp'],
      };
    } else {
      throw Exception('Failed to load data');
    }
  }
}
