import 'package:flutter/material.dart';
import 'package:wheather_app/model/weather_forecast_model.dart';
import 'package:wheather_app/widgets/forecast_card.dart';

class BottomListView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecastModel> snapshot;
  const BottomListView({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;

    if (forecastList == null) {
      return Placeholder();
    }

    return Column(
      mainAxisAlignment: .start,
      children: [
        Text(
          '7-Day Weather Forecast'.toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            color: Colors.black87,
            fontWeight: .bold,
          ),
        ),
        Container(
          height: 160,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: ListView.separated(
            scrollDirection: .horizontal,
            separatorBuilder: (context, index) => SizedBox(width: 8),
            itemCount: forecastList.length,
            itemBuilder: (context, index) => Container(
              width: MediaQuery.of(context).size.width / 2.7,
              height: 140,
              color: Colors.black87,
              child: forecastCard(snapshot, index),
            ),
          ),
        ),
      ],
    );
  }
}
