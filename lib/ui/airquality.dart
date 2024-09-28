  import 'dart:convert';

  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:intl/intl.dart';
  import 'package:http/http.dart' as http;
  import 'package:weather_app/component/aqiGauge.dart';
import 'package:weather_app/component/load.dart';
  import 'package:weather_app/component/navbarApp.dart';
  import 'package:weather_app/models/constants.dart';
  import 'package:weather_app/component/builAirQualityDetail.dart';



  class Airquality extends StatefulWidget {
    const Airquality({super.key});

    @override
    State<Airquality> createState() => _AirqualityState();
  }

  class _AirqualityState extends State<Airquality> {
    TextEditingController cityController = TextEditingController();

    String apikey = "932cb7aea5044dc582a33637242609";
    String location = "Hanoi";
    Map<String, dynamic> airQualityData = {};
    double co = 0.0;
    double no2 = 0.0;
    double o3 = 0.0;
    double so2 = 0.0;
    double pm25 = 0.0;
    double pm10 = 0.0;
    int usEpaIndex = 0;
    int gbDefraIndex = 0;
    String weatherIcon = "lightcloud.png";

    Size? size;
    Constants myconstants = Constants();

    bool isloading = true;


    @override
    void initState() {
      super.initState();
      fetchAirQuality(location);
    }

    void fetchAirQuality(String city) async {

      try {
        var url = Uri.parse(
            'https://api.weatherapi.com/v1/current.json?key=$apikey&q=$city&aqi=yes');
        var response = await http.get(url);
        setState(() {
          isloading = true;
        });


        if (response.statusCode == 200) {
          var data = json.decode(response.body);

          setState(() {
            location = data['location']['name'];
            weatherIcon = data['current']['condition']['text'].toLowerCase().replaceAll(" ", "") + ".png";
            airQualityData = data['current']['air_quality'];

            co = airQualityData['co'];
            no2 = airQualityData['no2'];
            o3 = airQualityData['o3'];
            so2 = airQualityData['so2'];
            pm25 = airQualityData['pm2_5'];
            pm10 = airQualityData['pm10'];
            usEpaIndex = airQualityData['us-epa-index'];
            // gbDefraIndex = airQualityData['gb-defra-index'];
          });

          print('Air Quality Data: $airQualityData');
        } else {
          print('Failed to load air quality data');
        }
      } catch (e) {
        print('Error occurred: $e');
      }finally {
        setState(() {
          isloading = false; // Kết thúc tải API
        });
      }
    }

    @override
    Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
      return Scaffold(
        body:isloading? Load(): SingleChildScrollView( // Bọc trong SingleChildScrollView
          child: Center(
            child: Container(
              // width: size.height * .5,
              // height: size.height,
              padding: EdgeInsets.only(top: 60, left: 10, right: 10),
              color: myconstants.primaryColor.withOpacity(.1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                height: size.height * 0.9,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Navbarapp(
                  cityController: cityController,
                  onSearch: fetchAirQuality,
                  fetchAirQuality: fetchAirQuality,
                  location: location,
                  myconstants: myconstants,
                        ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            width: 2.0,
                            color: myconstants.primaryColor.withOpacity(0.6),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: AQIGauge(aqi: usEpaIndex),
                        width: double.infinity,
                        height: size.height * 0.5,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    // Row chứa NO2 và SO2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        builAirQualityDetail(label: 'NO2', value: no2),
                        builAirQualityDetail(label: 'SO2', value: so2),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Row chứa PM2.5 và PM10
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        builAirQualityDetail(label: 'PM2.5', value: pm25),
                        builAirQualityDetail(label: 'PM10', value: pm10),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
}
