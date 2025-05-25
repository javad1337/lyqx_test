import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle headline1 = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Colors.black87,
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: 'Lato',
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Urbanist',
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
