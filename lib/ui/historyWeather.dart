import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class HistoryWeather extends StatefulWidget {
  final String location;

  HistoryWeather({required this.location});

  @override
  _HistoryWeatherState createState() => _HistoryWeatherState();
}

class _HistoryWeatherState extends State<HistoryWeather> {
  List<Map<String, dynamic>> temperatureData = [];

  @override
  void initState() {
    super.initState();
    fetchWeatherHistory(widget.location);
  }

  Future<void> fetchWeatherHistory(String location) async {
    DateTime today = DateTime.now();
    String apiKey = "932cb7aea5044dc582a33637242609";
    List<Map<String, dynamic>> tempData = [];

    for (int i = 0; i < 7; i++) {
      DateTime date = today.subtract(Duration(days: i));
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      String url =
          "https://api.weatherapi.com/v1/history.json?key=$apiKey&q=$location&dt=$formattedDate";

      try {
        var response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          double temp = data["forecast"]["forecastday"][0]["day"]["avgtemp_c"];
          tempData.add({"date": formattedDate, "temperature": temp});
        } else {
          print("Failed to load weather data for $formattedDate");
        }
      } catch (e) {
        print("Error occurred: $e");
      }
    }

    setState(() {
      temperatureData = tempData.reversed.toList(); // Đảo ngược thứ tự cho đúng thời gian.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("7-Day Temperature History")),
      body: temperatureData.isNotEmpty
          ? Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: true),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  getTitlesWidget: (value, meta) {
                    return Text(temperatureData[value.toInt()]["date"].substring(5));
                  },
                  interval: 1,
                  // margin: 8,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
            ),
            borderData: FlBorderData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(temperatureData.length, (index) {
                  return FlSpot(
                    index.toDouble(),
                    temperatureData[index]["temperature"],
                  );
                }),
                isCurved: true,
                color: Colors.blue,
                barWidth: 4,
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blue.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
