
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class builAirQualityDetail extends StatefulWidget {
  const builAirQualityDetail({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final double value;

  @override
  State<builAirQualityDetail> createState() => _builAirQualityDetailState();
}

class _builAirQualityDetailState extends State<builAirQualityDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(width: 10,),
          Text(
            widget.value.toString(),
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}