import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/component/infoWeather.dart';
import 'package:weather_app/component/load.dart';
import 'package:weather_app/component/navbarApp.dart';
import 'package:weather_app/models/constants.dart';
import 'package:http/http.dart' as http;
import "package:flutter/src/material/icons.dart";
import 'package:weather_app/ui/detailpage.dart';
import 'package:weather_app/ui/historyWeather.dart';


class mainApp extends StatefulWidget {
  const mainApp({super.key});

  @override
  State<mainApp> createState() => _MainAppState();
}

class _MainAppState extends State<mainApp> {
  TextEditingController cityController = TextEditingController();

  static String apikey = "932cb7aea5044dc582a33637242609";
  static String location = "Hanoi";
  String weatherIcon = "lightcloud.png";
  int temperature = 0;
  int winSpeed = 0;
  int humidity = 0;
  int cloud = 0;
  String currentDate = "";
  List hourlyWeatherForecast = [];
  List dailyWeatherForcast = [];
  String currentWeatherStatus = "";
  String searchWeatherAPI =
      "https://api.weatherapi.com/v1/forecast.json?key=$apikey&days=7&q=";
  Constants myconstants = Constants();

  bool isloading = true;

  void fetchAPIWeather(String searchText) async {
    try {
      setState(() {
        isloading = true; // Bắt đầu tải API
      });

      var searchresult = await http.get(
          Uri.parse(searchWeatherAPI + searchText));

      if (searchresult.statusCode == 200) {
        final weatherData = json.decode(searchresult.body);

        if (weatherData != null && weatherData['location'] != null) {
          var locationData = weatherData["location"];
          var currentweather = weatherData["current"];

          setState(() {
            location = GetshortLocationname(locationData["name"]);
            var parseDate = DateTime.parse(
                locationData["localtime"].substring(0, 10));
            var newDate = DateFormat("MMMMEEEEd").format(parseDate);
            currentDate = newDate;

            // current
            currentWeatherStatus = currentweather["condition"]["text"];
            weatherIcon = currentWeatherStatus.toLowerCase().replaceAll(" ", "") + ".png";
            temperature = currentweather["temp_c"].toInt();
            winSpeed = currentweather["wind_kph"].toInt();
            humidity = currentweather["humidity"].toInt();
            cloud = currentweather["cloud"].toInt();

            // forecast
            dailyWeatherForcast = weatherData["forecast"]["forecastday"];
            hourlyWeatherForecast = dailyWeatherForcast[0]["hour"];
          });
        } else {
          print("No location data found");
        }
      } else {
        print("Failed to load weather data");
      }
    } catch (e) {
      print("Error occurred: $e");
    } finally {
      setState(() {
        isloading = false; // Kết thúc tải API
      });
    }
  }


  static String GetshortLocationname(String name) {
    List<String> wordlist = name.split(" ");


    if (wordlist.isNotEmpty) {
      if (wordlist.length > 1) {
        return wordlist[0] + " " + wordlist[1];
      } else {
        return wordlist[0];
      }
    } else {
      return " ";
    }
  }


  @override
  void initState() {
    fetchAPIWeather(location);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

        Size size = MediaQuery
            .of(context)
            .size;


    return Scaffold(
      body: isloading ?
       Load():
      Center(
        child: Container(
          width: size.height * .5,
          height: size.height,
          padding: EdgeInsets.only(top: 60, left: 10, right: 10),
          color: myconstants.primaryColor.withOpacity(.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: size.height * 0.7,
                decoration: BoxDecoration(
                  gradient: myconstants.tertiaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: myconstants.primaryColor.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child:      Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Navbarapp(
                      cityController: cityController,
                      onSearch: fetchAPIWeather,
                      fetchAirQuality: fetchAPIWeather,
                      location: location,
                      myconstants: myconstants,
                    ),
                    SizedBox(
                      height: 160,
                      child: Image.asset("assets/" + weatherIcon),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.only(top: 9.0),
                        child: Text(temperature.toString(),
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                        ),),
                        Text("o",
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    Text(currentWeatherStatus, style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0
                     ),),
                    Text(currentDate, style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                    ),),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InfoWeather(
                          winspeed: winSpeed.toInt() ,
                          unit: "km/h",
                          imageUrl: "assets/windspeed.png",
                        ),
                        InfoWeather(
                          winspeed: humidity.toInt() ,
                          unit: "%",
                          imageUrl: "assets/humidity.png",
                        ),
                        InfoWeather(
                          winspeed: cloud.toInt() ,
                          unit: "%",
                          imageUrl: "assets/cloud.png",
                        )
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 10),
                height: size.height * .2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[ Text("Today",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),),
                        GestureDetector(
                          onTap: () {
                            if (dailyWeatherForcast != null && dailyWeatherForcast.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detailpage(dailyForecast: dailyWeatherForcast),
                                ),
                              );
                            } else {
                              print("No data available");
                            }
                          },
                          child: Text(
                            "Forecast",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: myconstants.tertiaryColor,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (dailyWeatherForcast != null && dailyWeatherForcast.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HistoryWeather(location: location)
                                ));
                            } else {
                              print("No data available");
                            }
                          },
                          child: Text(
                            "History",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: myconstants.blackColor,
                            ),
                          ),
                        ),

                        
                        ]
                    ),
                  SizedBox(height: 10,),
                    SizedBox(
                      height: 110,
                      child: ListView.builder(
                        itemCount: hourlyWeatherForecast.length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          String currentTime =
                          DateFormat('HH:mm:ss').format(DateTime.now());
                          String currentHour = currentTime.substring(0, 2);

                          String forecastTime = hourlyWeatherForecast[index]
                          ["time"]
                              .substring(11, 16);
                          String forecastHour = hourlyWeatherForecast[index]
                          ["time"]
                              .substring(11, 13);

                          String forecastWeatherName =
                          hourlyWeatherForecast[index]["condition"]["text"];
                          String forecastWeatherIcon = forecastWeatherName
                              .replaceAll(' ', '')
                              .toLowerCase() +
                              ".png";

                          String forecastTemperature =
                          hourlyWeatherForecast[index]["temp_c"]
                              .round()
                              .toString();
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            margin: const EdgeInsets.only(right: 20),
                            width: 65,
                            decoration: BoxDecoration(
                                color: currentHour == forecastHour
                                    ? Colors.white
                                    : myconstants.primaryColor,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 1),
                                    blurRadius: 5,
                                    color:
                                    myconstants.primaryColor.withOpacity(.2),
                                  ),
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  forecastTime,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: myconstants.grayColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Image.asset(
                                  'assets/' + forecastWeatherIcon,
                                  width: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      forecastTemperature,
                                      style: TextStyle(
                                        color: myconstants.grayColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'o',
                                      style: TextStyle(
                                        color: myconstants.grayColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        fontFeatures: const [
                                          FontFeature.enable('sups'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
