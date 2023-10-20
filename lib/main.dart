import 'package:apiproject/HomeScreen.dart';
import 'package:apiproject/LoginScreen.dart';
import 'package:apiproject/Loginscreen1.dart';
import 'package:apiproject/Ragisterscreen.dart';
import 'package:apiproject/Socialcomunitylist.dart';
import 'package:apiproject/Socialcomunitylist2.dart';
import 'package:apiproject/Splacescreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  runApp(const MyApp());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("token", "12344");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}


