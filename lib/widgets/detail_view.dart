import 'package:flutter/material.dart';
import 'package:wheather_app/model/weather_forecast_model.dart';
import 'package:wheather_app/utilities/forecast_util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastModel> snapshot;
  const DetailView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var pressure = forecastList?[0].pressure;
    var humidity = forecastList?[0].humidity;
    var wind = forecastList?[0].speed;

    if (pressure == null || humidity == null || wind == null) {
      return Placeholder();
    } else {
      pressure *= 0.750062;
    }
    return Container(
      child: Row(
        mainAxisSize: .max,
        mainAxisAlignment: .spaceEvenly,
        children: [
          Util.getItem(
            FontAwesomeIcons.temperatureThreeQuarters,
            pressure.round(),
            'mm Hg',
          ),
          Util.getItem(FontAwesomeIcons.cloudRain, humidity, '%'),
          Util.getItem(FontAwesomeIcons.wind, wind.toInt(), 'm/s'),
        ],
      ),
    );
  }
}
