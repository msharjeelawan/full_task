import 'package:flutter/material.dart';

class MyProgressLoader{

  //progress loader dialog
  static void showLoader(context){
    showDialog(context: context, barrierDismissible: false, builder: (context){
      return AlertDialog(
        title: const Text("Please wait"),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator()
          ],
        ),
      );
    });
  }
}