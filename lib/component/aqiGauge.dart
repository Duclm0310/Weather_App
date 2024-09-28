import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class AQIGauge extends StatelessWidget {
  final int aqi;

  String _getAQILabel(int aqi) {
    if (aqi >= 0 && aqi <= 1) {
      return 'Good';
    } else if (aqi > 1 && aqi <= 2) {
      return 'Moderate';
    } else if (aqi > 2 && aqi <= 3) {
      return 'Quite Unhealthy';
    } else if (aqi > 3 && aqi <= 4) {
      return 'Unhealthy';
    } else if (aqi > 4 && aqi <= 5) {
      return 'Very Unhealthy';
    } else {
      return 'Hazardous';
    }
  }

  Color _getAQIColor(int aqi) {
    if (aqi >= 0 && aqi <= 1) {
      return Colors.green;
    } else if (aqi > 1 && aqi <= 2) {
      return Colors.yellow;
    } else if (aqi > 2 && aqi <= 3) {
      return Colors.orange;
    } else if (aqi > 3 && aqi <= 4) {
      return Colors.red;
    } else if (aqi > 4 && aqi <= 5) {
      return Colors.purple;
    } else {
      return Colors.brown;
    }
  }

  AQIGauge({required this.aqi});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Gauge Chart
        SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 6,
              ranges: <GaugeRange>[
                GaugeRange(startValue: 0, endValue: 1, color: Colors.green),
                GaugeRange(startValue: 1, endValue: 2, color: Colors.yellow),
                GaugeRange(startValue: 2, endValue: 3, color: Colors.orange),
                GaugeRange(startValue: 3, endValue: 4, color: Colors.red),
                GaugeRange(startValue: 4, endValue: 5, color: Colors.purple),
                GaugeRange(startValue: 5, endValue: 6, color: Colors.brown),
              ],
              pointers: <GaugePointer>[
                NeedlePointer(value: aqi.toDouble()), // Chỉ số AQI được hiển thị
              ],
              annotations: <GaugeAnnotation>[
                // Chỉ số AQI ở trung tâm
                GaugeAnnotation(
                  widget: Text(
                    '$aqi',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: _getAQIColor(aqi), ),
                  ),
                  angle: 90,
                  positionFactor: 0.4, // Định vị chính giữa đồng hồ
                ),
                // Nhãn mô tả mức AQI bên dưới đồng hồ
                GaugeAnnotation(
                  widget: Text(
                    _getAQILabel(aqi),  // Lấy nhãn dựa trên giá trị AQI
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: _getAQIColor(aqi),  // Đổi màu theo chỉ số AQI
                    ),
                  ),
                  angle: 90,
                  positionFactor: 1, // Định vị dưới đồng hồ
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
