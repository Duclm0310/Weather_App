import 'package:flutter/widgets.dart';
import 'package:weather_app/models/constants.dart';

import 'package:flutter/material.dart';
import 'package:weather_app/ui/airquality.dart';

import '../ui/infomationScreen.dart';
import '../ui/mainapp.dart';

class Navbarapp extends StatefulWidget {
  final TextEditingController cityController;
  final Function(String) onSearch;
  final Function fetchAirQuality;
  final String location;
  final Constants myconstants;

  Navbarapp({
    required this.cityController,
    required this.onSearch,
    required this.fetchAirQuality,
    required this.location,
    required this.myconstants,
  });

  @override
  State<Navbarapp> createState() => _NavbarappState();
}

class _NavbarappState extends State<Navbarapp> {
  void _navigateTo(String routeName) {
    if (routeName == 'MainApp') {
      // Thực hiện điều hướng đến MainApp
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => mainApp()),
      );
    } else if (routeName == 'AirQuality') {
      // Thực hiện điều hướng đến AirQuality
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Airquality()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PopupMenuButton<String>(
          onSelected: (value) {
            _navigateTo(value);
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'MainApp',
              child: Text('Weather Forecast'),
            ),
            PopupMenuItem<String>(
              value: 'AirQuality',
              child: Text('Air Quality'),
            ),
          ],
          child:
          Image.asset("assets/menu.png", width: 40, height: 40),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 2),
              Text(
                widget.location.isNotEmpty ? widget.location : "Select a city",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              IconButton(
                onPressed: () {
                  widget.cityController.clear();
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      height: size.height * .2,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 70,
                            child: Divider(
                              thickness: 3.5,
                              color: widget.myconstants.primaryColor,
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            onChanged: (searchText) {
                              widget.onSearch(searchText);
                            },
                            controller: widget.cityController,
                            autofocus: true,
                            decoration: InputDecoration(
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  if (widget.cityController.text.isNotEmpty) {
                                    widget.fetchAirQuality(widget.cityController.text);
                                  } else {
                                    print("Please enter a city name");
                                  }
                                },
                                child: Icon(Icons.search, color: widget.myconstants.primaryColor),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () => widget.cityController.clear(),
                                child: Icon(Icons.close, color: widget.myconstants.primaryColor),
                              ),
                              hintText: "Search city",
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: widget.myconstants.primaryColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Infomationscreen()),
                );
              },
              child: Image.asset(
                "assets/started.png",
                width: 40,
                height: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
