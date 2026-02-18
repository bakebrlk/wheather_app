import 'dart:convert';
import 'dart:developer';

import 'package:wheather_app/model/weather_forecast_model.dart';
import 'package:http/http.dart' as http;
import 'package:wheather_app/utilities/constants.dart';

class WeatherApi {
  Future<WeatherForecastModel> fetchWeatherForecastWithCity({
    required String cityName,
  }) async {
    var queryParameters = {
      'APPID': Constants.WEATHER_APP_ID,
      'units': 'metric',
      'q': cityName,
    };

    var uri = Uri.https(
      Constants.WEATHER_BASE_URL_DOMAIN,
      Constants.WEATHER_FORECAST_PATH,
      queryParameters,
    );

    log('reauest: ${uri.toString()}');

    var response = await http.get(uri);
    print('response: ${response.body}');

    if (response.statusCode == 200) {
      return WeatherForecastModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error response');
    }
  }
}
