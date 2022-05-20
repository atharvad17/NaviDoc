// @dart=2.9
import 'package:flutter/material.dart';
import 'package:navi_doc/Model/UserLogin.dart';
import 'package:navi_doc/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<MyHomePage> {
  UserLogin userLogin;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=> SharedPreferences.getInstance().then((prefs) => {
              userLogin = userLoginFromJson(prefs.getString("UserLogin").toString()),

              if(userLogin != null)
                {
                  Navigator.pop(context,true),
                  Navigator.push(context,MaterialPageRoute(builder: (context) => const HomeScreen()))
                }
              else
                {
                  Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => const LoginScreen()))
                }
            }).onError((error, stackTrace) => Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => LoginScreen())))

    );



  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Image.asset('assets/images/navigo3.jpg', height: 200, width: 200,),
//        FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}

