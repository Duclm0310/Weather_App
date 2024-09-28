


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InfoWeather extends StatelessWidget {
  final int winspeed;
  final String unit;
  final String imageUrl;

  const InfoWeather({
    super.key, required this.winspeed, required this.unit, required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              // color: Colors.grey,
              borderRadius: BorderRadius.circular(10)
          ),
          child: Image.asset(imageUrl),
        ),
        SizedBox(height: 10,),
        Text(winspeed.toString() + unit, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),)
      ],
    );
  }
}
