import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wheather_app/services/weather_api_provider.dart';
import 'package:wheather_app/screens/weather_forecast_screen.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  void getLocationData() async {
    try {
      var weatherInfo = await WeatherProvider().fetchWeatherForecast();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WeatherForecastScreen(locationWeather: weatherInfo);
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(color: Colors.black87, size: 100),
      ),
    );
  }
}
