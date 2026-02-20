import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wheather_app/services/weather_api_provider.dart';
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
  late String _cityName;

  @override
  void initState() {
    super.initState();

    if (widget.locationWeather != null) {
      forecastObject = Future.value(widget.locationWeather);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Weather Map', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            setState(() {
              forecastObject = WeatherProvider().fetchWeatherForecast();
            });
          },
          icon: Icon(Icons.my_location),
        ),
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
                  forecastObject = WeatherProvider().fetchWeatherForecast(
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
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'City not found \nPlease, enter correct city',
                    style: TextStyle(fontSize: 25),
                    textAlign: .center,
                  ),
                );
              } else if (snapshot.hasData) {
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
                  child: CircularProgressIndicator(), // пока грузится
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
