
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/models/constants.dart';

class WeatherCard extends StatelessWidget {
  final Map<String, dynamic> forecastWeather;

  WeatherCard({required this.forecastWeather});

  @override
  Widget build(BuildContext context) {
    Constants myconstants = Constants();
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  forecastWeather["forecastDate"],
                  style: const TextStyle(
                    color: Color(0xff6696f5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      forecastWeather["minTemperature"].toString(),
                      style: TextStyle(
                        color: myconstants.grayColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "o",
                      style: TextStyle(
                        color: myconstants.grayColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFeatures: const [FontFeature.enable('sups')],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      forecastWeather["maxTemperature"].toString(),
                      style: TextStyle(
                        color: myconstants.blackColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "o",
                      style: TextStyle(
                        color: myconstants.blackColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        fontFeatures: const [FontFeature.enable('sups')],
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/' + forecastWeather["weatherIcon"],
                      width: 30,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      forecastWeather["weatherName"],
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      forecastWeather["chanceOfRain"].toString() + "%",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Image.asset(
                      'assets/lightrain.png',
                      width: 30,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
