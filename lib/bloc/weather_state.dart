import 'package:wheather_app/model/weather_forecast_model.dart';

abstract class WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  WeatherForecastModel model;
  WeatherLoadedState({required this.model});
}

class WeatherErrorState extends WeatherState {}