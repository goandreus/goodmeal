import 'dart:convert';

import 'package:goodmeal/data/models/weather.dart';
import "package:http/http.dart" as http;

Future<WeeklyWeather> fetchWeeklyWeather(String cityName) async {
  final response = await http.get(
      'https://api.openweathermap.org/data/2.5/forecast/daily?q=$cityName&units=metric&appid=4d549679691769c85c1c782f4f20ce07');
  if (response.statusCode == 200) {
    return WeeklyWeather.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("No se pudieron obtener los datos $cityName");
  }
}
