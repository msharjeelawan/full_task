import 'package:flutter/material.dart';

class MySnackBar{

  static ScaffoldFeatureController showSnackBar(context,message){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}