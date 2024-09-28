

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/component/infoWeather.dart';
import 'package:weather_app/component/weatherCard.dart';
import 'package:weather_app/models/constants.dart';
class Detailpage extends StatefulWidget {
  final dailyForecast;
  const Detailpage({super.key, this.dailyForecast});

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {

  @override
  Widget build(BuildContext context) {
    final Constants myconstants = Constants();
    Size size = MediaQuery.of(context).size;
    var weatherData = widget.dailyForecast;


    Map <String, dynamic> getForecastweather (int index){
      int maxWind = weatherData[index]["day"]["maxwind_kph"].toInt();
      int avghumidity = weatherData[index]["day"]["avghumidity"].toInt();
      int chanceofRain = weatherData[index]["day"]["daily_chance_of_rain"].toInt();
      var parseDate =DateTime.parse(weatherData[index]["date"]);
      var forecastDate = DateFormat('EEEE, d MMMM').format(parseDate);

      String weatherName = weatherData[index]["day"]["condition"]["text"];
      String weatherIcon =
          weatherName.replaceAll(' ', '').toLowerCase() + ".png";

      int minTemperature = weatherData[index]["day"]["mintemp_c"].toInt();
      int maxTemperature = weatherData[index]["day"]["maxtemp_c"].toInt();

      var forecastData = {
        'maxWindSpeed': maxWind,
        'avgHumidity': avghumidity,
        'chanceOfRain': chanceofRain,
        'forecastDate': forecastDate,
        'weatherName': weatherName,
        'weatherIcon': weatherIcon,
        'minTemperature': minTemperature,
        'maxTemperature': maxTemperature
      };
      return forecastData;
    }
    return Scaffold(
      backgroundColor: myconstants.primaryColor.withOpacity(0.5),
      appBar: AppBar(
        title: const Text('Forecasts'),
        centerTitle: true,
        backgroundColor: myconstants.primaryColor,
        elevation: 0.0,
      ),
      body: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: 0,
              top: 70,
              child: Container(
                height: size.height* 0.75,
                width: size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                    children: [
                    Positioned(
                    top: -50,
                    right: 20,
                    left: 20,
                    child: Container(
                      height: 300,
                      width: size.width * .7,
                      decoration: BoxDecoration(
                      gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.center,
                      colors: [
                        Color(0xffa9c1f5),
                        Color(0xff6696f5),
                          ]),
                    boxShadow: [
                        BoxShadow(
                        color: Colors.blue.withOpacity(.1),
                        offset: const Offset(0,  25),
                        blurRadius: 3,
                        spreadRadius: -10,
                        ),
                    ],
                  borderRadius: BorderRadius.circular(15),
                  ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: Image.asset("assets/" +
                                getForecastweather(0)["weatherIcon"]),
                            width: 150,
                          ),
                          Positioned(
                              top: 150,
                              left: 30,
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  getForecastweather(0)["weatherName"],
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Container(
                              width: size.width * .8,
                              padding:
                              const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  InfoWeather(
                                    winspeed: getForecastweather(0)["maxWindSpeed"],
                                    unit: "km/h",
                                    imageUrl: "assets/windspeed.png",
                                  ),
                                  InfoWeather(
                                    winspeed: getForecastweather(0)["avgHumidity"],
                                    unit: "%",
                                    imageUrl: "assets/humidity.png" ,
                                  ),
                                  InfoWeather(
                                    winspeed: getForecastweather(0)["chanceOfRain"],
                                    unit: "%",
                                    imageUrl: "assets/lightrain.png",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                )
              ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getForecastweather(0)["maxTemperature"]
                                  .toString(),
                              style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                            Text(
                              'o',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                          top: 320,
                          left: 0,
                          child: SizedBox(
                            height: 400,
                            width: size.width * .9,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                WeatherCard(forecastWeather: getForecastweather(0)),
                                WeatherCard(forecastWeather: getForecastweather(1)),
                                WeatherCard(forecastWeather: getForecastweather(2)),
                              ],
                            ),
                          ),
                      ),
        ],
      ),
    ))]
      )
    );
  }
}
