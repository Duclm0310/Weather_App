import 'dart:ui';
import 'package:flutter/material.dart';

class Constants{
  final Color primaryColor = const Color(0xff90B2F9);
  final Color secondColor = const Color(0xff90B2F8);
  final tertiaryColor = const Color(0xff205cf1);
  final blackColor = const Color(0xff1a1d26);
  final grayColor = const Color(0xffd9dadb);

  final Gradient primaryGradient = const LinearGradient(
    colors: [
      Color(0xff90B2F9), // primaryColor
      Color(0xff90B2F8), // secondColor
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradient 2: Từ tertiaryColor đến grayColor
  final Gradient secondaryGradient = const LinearGradient(
    colors: [
      Color(0xff205cf1), // tertiaryColor
      Color(0xffd9dadb), // grayColor
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Gradient 3: Từ blackColor đến primaryColor và grayColor
  final Gradient tertiaryGradient = const LinearGradient(
    colors: [
      Color(0xff1a1d26), // blackColor
      Color(0xff90B2F9), // primaryColor
      Color(0xffd9dadb), // grayColor
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );

  String apiKey = "932cb7aea5044dc582a33637242609";


}