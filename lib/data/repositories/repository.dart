import 'package:goodmeal/data/models/weather.dart';
import 'package:goodmeal/data/repositories/weather_repository.dart';

class Repository {
  static Future<WeeklyWeather> fetchWeather(String cityName) =>
      fetchWeeklyWeather(cityName);
}
