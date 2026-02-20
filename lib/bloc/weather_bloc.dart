// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather_app/bloc/weather_event.dart';
import 'package:wheather_app/bloc/weather_state.dart';
import 'package:wheather_app/services/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final WeatherRepository repository;

  WeatherBloc({required this.repository}) : super(WeatherLoadingState()) {
    on<WeatherFetchEvent>((event, emit) async {
      emit(WeatherLoadingState());

      try {
        final fetchedWeather = await repository.fetchWeatherForecast(cityName: event.cityName, isCity: event.isCity);
        emit(WeatherLoadedState(model: fetchedWeather));
      } catch (_) {
        emit(WeatherErrorState());
      }
    });
  }
}