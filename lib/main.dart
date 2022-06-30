import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task/Helpers/Constant.dart';
import 'package:test_task/Views/home_screen.dart';
import 'package:test_task/Views/login_screen.dart';

void main() async{
  //this method is called when data is required before initialization of app
  WidgetsFlutterBinding.ensureInitialized();
  bool? isLogin = await isUserLogin();
  runApp(MyApp(isLogin:isLogin));
}

class MyApp extends StatelessWidget {
  final bool? isLogin;
  const MyApp({Key? key,this.isLogin}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Test Task',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        primaryColor: Constant.primaryColor,
      ),
      home: LoginScreen(),
      initialRoute:isLogin==null? "/login" : "/home",
      routes: {
        "/login":(context) => LoginScreen(),
        "/home":(context) => HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }



}
//get from shared preferrence that user state is login or not
Future<bool?> isUserLogin() async{
  var pref =  await SharedPreferences.getInstance();
  return pref.getBool("isLogin");
}
