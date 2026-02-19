import 'package:flutter/material.dart';
import 'package:wheather_app/model/weather_forecast_model.dart';

class TempView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastModel> snapshot;
  const TempView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var icon = forecastList?[0].getIconUrl();
    var temp = forecastList?[0].temp?.day?.toStringAsFixed(0);
    var description = forecastList?[0].weather?[0].description?.toUpperCase();

    if (forecastList == null ||
        icon == null ||
        temp == null ||
        description == null) {
      return Placeholder();
    }

    return Container(
      child: Row(
        mainAxisAlignment: .center,
        children: [
          Image.network(icon, scale: 0.4),
          SizedBox(width: 20),
          Column(
            children: [
              Text(
                '$temp °C',
                style: TextStyle(fontSize: 54, color: Colors.black87),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
