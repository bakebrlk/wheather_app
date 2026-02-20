import 'dart:convert';
import 'dart:developer';

import 'package:wheather_app/model/weather_forecast_model.dart';
import 'package:http/http.dart' as http;
import 'package:wheather_app/utilities/constants.dart';
import 'package:wheather_app/utilities/location.dart';

class WeatherApi {
  Future<WeatherForecastModel> fetchWeatherForecast({
    String cityName = '',
    bool isCity = false,
  }) async {
    Location location = Location();
    await location.getCurrentLocation();

    Map<String, String> parameters;

    if (isCity) {
      var queryParameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'q': cityName,
      };
      parameters = queryParameters;
    } else {
      var queryParameters = {
        'APPID': Constants.WEATHER_APP_ID,
        'units': 'metric',
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
      };
      parameters = queryParameters;
    }

    var uri = Uri.https(
      Constants.WEATHER_BASE_URL_DOMAIN,
      Constants.WEATHER_FORECAST_PATH,
      parameters,
    );

    log('reauest: ${uri.toString()}');

    var response = await http.get(uri);
    print('response: ${response.body}');

    if (response.statusCode == 200) {
      return WeatherForecastModel.fromJson(json.decode(response.body));
    } else {
      return Future.error('Error response');
    }
  }
}
