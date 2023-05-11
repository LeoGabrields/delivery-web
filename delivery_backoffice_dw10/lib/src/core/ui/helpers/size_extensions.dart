import 'package:flutter/material.dart';

extension SizedExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenShortesSide => MediaQuery.of(this).size.shortestSide;
  double get screenLongestSide => MediaQuery.of(this).size.longestSide;

  double percentWidth(double percent) => screenWidth * percent;
  double percentHeight(double percent) => screenHeight * percent;
  double percentShortesSide(double percent) => screenShortesSide * percent;
  double percentLongestSide(double percent) => screenLongestSide * percent;

}
