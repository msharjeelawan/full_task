import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task/Views/login_screen.dart';
import 'package:test_task/Widgets/MyProgressLoader.dart';

import '../Widgets/MySnackBar.dart';


class LoginService{

  final String _apiHost="http://buddy.ropstambpo.com/api/";
  final device_token="zasdcvgtghnkiuhgfde345tewasdfghjkm";
  //for login screen
  void login({email,password,context}) async{
    //show loader
    MyProgressLoader.showLoader(context);
    http.Response response = await http.post(
        Uri.parse(_apiHost+"login?email=$email&password=$password&device_token=$device_token"),
    );
    // print(response.body);
    // print(response.statusCode);
    if(response.statusCode==200){
      if(response.body.isNotEmpty){
        //convert response to map
        Map<String,dynamic> map = jsonDecode(response.body);
        if(map["data"]["user"]!=null){
          Map<String,dynamic> userMap = map["data"]["user"];
          var pref  = await SharedPreferences.getInstance();
          pref.setBool("isLogin", true);
          //hide loader
          Navigator.pop(context);
          //show success message
          MySnackBar.showSnackBar(context, "Login Successfully");
          Navigator.of(context).pushNamedAndRemoveUntil("/home",(route)=> false);
        }else if(map["Message"]!=null){
          //hide loader
          Navigator.pop(context);
          MySnackBar.showSnackBar(context, map["Message"].toString());
        }
      }else{
        //hide loader
        Navigator.pop(context);
        MySnackBar.showSnackBar(context, "response is empty");
      }
    }else{
      //hide loader
      Navigator.pop(context);
      MySnackBar.showSnackBar(context, response.statusCode.toString());
    }
  }

}
