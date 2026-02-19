import 'package:flutter/material.dart';
import 'package:wheather_app/model/weather_forecast_model.dart';
import 'package:wheather_app/utilities/forecast_util.dart';

class CityView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastModel> snapshot;
  const CityView({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var city = snapshot.data?.city?.name;
    var country = snapshot.data?.city?.country;
    var forecastList = snapshot.data?.list;
    var formattedDate;

    if (city == null || country == null || forecastList == null) {
      return Text('City can${"'"}t find!');
    } else {
      formattedDate = DateTime.fromMillisecondsSinceEpoch(
        forecastList[0].dt! * 1000,
      );
    }

    return Container(
      child: Column(
        children: [
          Text(
            "${city}, ${country}",
            style: TextStyle(
              fontSize: 28,
              fontWeight: .bold,
              color: Colors.black87,
            ),
          ),
          Text(
            Util.getFormattedDate(formattedDate),
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
