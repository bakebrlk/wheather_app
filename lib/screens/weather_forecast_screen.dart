import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wheather_app/api/weather_api.dart';
import 'package:wheather_app/model/weather_forecast_model.dart';
import 'package:wheather_app/screens/city_screen.dart';
import 'package:wheather_app/widgets/bottom_list_view.dart';
import 'package:wheather_app/widgets/city_view.dart';
import 'package:wheather_app/widgets/detail_view.dart';
import 'package:wheather_app/widgets/temp_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  final locationWeather;
  const WeatherForecastScreen({super.key, this.locationWeather});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecastModel> forecastObject;
  String _cityName = 'Shu';

  @override
  void initState() {
    super.initState();

    if (widget.locationWeather != null) {
      forecastObject = WeatherApi().fetchWeatherForecast();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Weather Map', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(onPressed: () {
          setState(() {
            forecastObject = WeatherApi().fetchWeatherForecast();
          });
        }, icon: Icon(Icons.my_location)),
        actions: [
          IconButton(
            onPressed: () async {
              var newCityName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CityScreen();
                  },
                ),
              );

              if (newCityName != null || newCityName != '') {
                setState(() {
                  _cityName = newCityName;
                  forecastObject = WeatherApi().fetchWeatherForecast(
                    cityName: _cityName,
                    isCity: true,
                  );
                });
              } else {
                log(newCityName);
              }
            },
            icon: Icon(Icons.location_city),
          ),
        ],
        foregroundColor: Colors.white,
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
                return Column(
                  children: [
                    SizedBox(height: 50),
                    CityView(snapshot: snapshot),
                    SizedBox(height: 50),
                    TempView(snapshot: snapshot),
                    SizedBox(height: 50),
                    DetailView(snapshot: snapshot),
                    SizedBox(height: 30),
                    BottomListView(snapshot: snapshot),
                  ],
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
