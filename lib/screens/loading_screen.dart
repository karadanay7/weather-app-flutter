

import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';



// ignore: use_key_in_widget_constructors
class LoadingScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  static const apiKey = '40ea811110f1f16c3f20f3afb6ea6c6f';
  late double latitude;
  late double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    longitude = location.longitude;
    latitude = location.latitude;
    NetworkHelper networkHelper = NetworkHelper(
      uri: Uri(
        scheme: 'https',
        host: 'api.openweathermap.org',
        path: 'data/2.5/weather',
        queryParameters: {
          'lat': latitude.toString(),
          'lon': longitude.toString(),
          'appid': apiKey,
        },
      ),
    );
    var weatherData = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder:(context) {
      return LocationScreen();
    }));
    // Handle weatherData as needed
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
