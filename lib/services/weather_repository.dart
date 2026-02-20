import 'package:wheather_app/model/weather_forecast_model.dart';
import 'package:wheather_app/services/weather_api_provider.dart';

class WeatherRepository {
  final WeatherProvider provider = WeatherProvider();

  Future<WeatherForecastModel> fetchWeatherForecast({required String cityName, required bool isCity}) =>
      provider.fetchWeatherForecast(cityName: cityName, isCity: isCity);
}
