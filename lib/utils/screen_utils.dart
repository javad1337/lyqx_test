import 'package:flutter/material.dart';

extension ScreenSizeExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;
}
