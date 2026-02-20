import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wheather_app/bloc/weather_bloc.dart';
import 'package:wheather_app/bloc/weather_event.dart';
import 'package:wheather_app/bloc/weather_state.dart';
import 'package:wheather_app/services/weather_api_provider.dart';
import 'package:wheather_app/model/weather_forecast_model.dart';
import 'package:wheather_app/screens/city_screen.dart';
import 'package:wheather_app/services/weather_repository.dart';
import 'package:wheather_app/widgets/bottom_list_view.dart';
import 'package:wheather_app/widgets/city_view.dart';
import 'package:wheather_app/widgets/detail_view.dart';
import 'package:wheather_app/widgets/temp_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherForecastScreen extends StatefulWidget {
  const WeatherForecastScreen({super.key});

  @override
  State<WeatherForecastScreen> createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  final repository = WeatherRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WeatherBloc(repository: repository)..add(WeatherFetchEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(appBar: _appBar(context), body: _body(context));
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    final WeatherBloc bloc = BlocProvider.of<WeatherBloc>(context);

    return AppBar(
      backgroundColor: Colors.black87,
      title: Text('Weather Map', style: TextStyle(color: Colors.white)),
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          bloc.add(WeatherFetchEvent());
        },
        icon: Icon(Icons.my_location),
      ),
      actions: [_locationButton(context)],
      foregroundColor: Colors.white,
    );
  }

  IconButton _locationButton(BuildContext context) {
    final WeatherBloc bloc = BlocProvider.of<WeatherBloc>(context);

    return IconButton(
      icon: Icon(Icons.location_city),
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
          bloc.add(WeatherFetchEvent(cityName: newCityName, isCity: true));
        } else {
          log(newCityName);
        }
      },
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoadedState) {
          return _displayWidget(state);
        } else if (state is WeatherLoadingState) {
          return _loadingWidget();
        } else if (state is WeatherErrorState) {
          return _errorWidget();
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  ListView _displayWidget(WeatherLoadedState state) {
    return ListView(
      children: [
        FutureBuilder(
          future: Future.value(state.model),
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
              return SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  Center _errorWidget() {
    return Center(
      child: Text(
        'City not found \nPlease, enter correct city',
        style: TextStyle(fontSize: 25),
        textAlign: .center,
      ),
    );
  }

  Center _loadingWidget() {
    return Center(child: CircularProgressIndicator());
  }
}
