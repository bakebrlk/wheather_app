import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wheather_app/api/weather_api.dart';
import 'package:wheather_app/model/weather_forecast_model.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecastModel> forecastObject;
  String _cityName = 'Shu';

  @override
  void initState() {
    super.initState();
    forecastObject = WeatherApi().fetchWeatherForecastWithCity(
      cityName: _cityName,
    );

    forecastObject.then((weather) {
      print(weather.list![0].weather![0].main);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Weather Map', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.location_city)),
      ),
      body: _body(context),
    );
  }

  ListView _body(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: FutureBuilder(
            future: forecastObject,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  'All good',
                  style: Theme.of(context).textTheme.headlineLarge,
                );
              } else {
                return Center(
                  child: SpinKitDoubleBounce(color: Colors.black87, size: 100),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
