import 'package:flutter/material.dart';

import '../Services/login_service.dart';

class LoginProvider with ChangeNotifier{
  bool isObscure = true;
  String email="";
  String password="";
  final formState=GlobalKey<FormState>();
  final service=LoginService();


  void showHidePassword(){
    isObscure? isObscure=false:isObscure=true;
    notifyListeners();
  }

  void signIn({context}) async {
    if (formState.currentState!.validate()) {
      formState.currentState!.save();
      service.login(email:email, password:password,context:context);
    }
  }


}