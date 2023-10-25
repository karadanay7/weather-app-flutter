import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;


// ignore: use_key_in_widget_constructors
class LoadingScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    print('this line of code is triggred');
    getData();
  }
  void getLocation() async{
    Location location = Location();
     await location.getCurrentLocation();
     print(location.longitude);
     print(location.latitude);
  }
  void getData() async {
  var url = Uri(scheme: 'https', host:'api.openweathermap.org', path: 'data/2.5/weather',queryParameters: { 'lat' : '44.34', 'lon' : '10.99', 'appid' : '40ea811110f1f16c3f20f3afb6ea6c6f'  } );
  var response = await http.get(url);
   print(response.body);
   print(url);
  }
  @override
  Widget build(BuildContext context) {
    getLocation();
    return Scaffold();
  }
}
