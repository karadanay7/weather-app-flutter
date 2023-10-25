import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

// ignore: use_key_in_widget_constructors
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.locationWeather});
  final locationWeather;

  @override
  // ignore: library_private_types_in_public_api
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
 WeatherModel weather = WeatherModel();
  late int temperature;
  late int condition;
  late String cityName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null ) {
        temperature = 0;
        condition = 0;
        cityName = 'Error'; // You can set a default city name or any appropriate error message
        return;

      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();

      if (weatherData['weather'] != null && weatherData['weather'].isNotEmpty) {
        condition = weatherData['weather'][0]['id'];
      } else {
        condition = 0;
      }
      if (weatherData['name'] != null) {
        cityName = weatherData['name'];
      } else {
        cityName = 'Unknown';
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                     var typedName =  await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      },),);
                     if(typedName != null) {
                         var weatherData = await weather.getCityWeather(typedName);
                         updateUI(weatherData);
                     }
                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
               Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      getWeatherIcon(widget.locationWeather['weather'][0]['id']) ,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  '${getMessage(temperature)} in $cityName' ,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
