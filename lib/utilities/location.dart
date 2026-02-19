import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude;

  Future<void> getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permissions are denied';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'Location permissions are permanently denied';
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.low,
          timeLimit: Duration(seconds: 5),
        ),
      );

      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      throw 'Something goes wrong $e';
    }
  }
}
