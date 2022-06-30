import 'package:flutter/material.dart';
class Constant {
  static double? _width, _height;

  static double getWidth(BuildContext context) {
    return _width ??= MediaQuery
        .of(context)
        .size
        .width;
  }

  static double getHeight(BuildContext context) {
    return _height ??= MediaQuery
        .of(context)
        .size
        .height;
  }


  static Color greenColor=const Color.fromRGBO(88, 178, 64, 1);
  static Color primaryColor=const Color.fromRGBO(208, 248, 223, 1);
  static Color black=Colors.black;
  static Color white=Colors.white;
}