abstract class WeatherEvent {}

class WeatherFetchEvent extends WeatherEvent {
  String cityName;
  bool isCity;

  WeatherFetchEvent({this.cityName = '', this.isCity = false});
}
