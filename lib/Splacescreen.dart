import 'package:apiproject/Homescreen1.dart';
import 'package:apiproject/Loginscreen1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splacescreen extends StatefulWidget {
  const Splacescreen({Key? key}) : super(key: key);

  @override
  State<Splacescreen> createState() => _SplacescreenState();
}

class _SplacescreenState extends State<Splacescreen> {

  checklogin() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("islogin"))
    {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=> Homescreen1())
      );
    }
    else
    {
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=> Loginscreen1())
      );
    }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      checklogin();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SPLACE SCREEN"),
      ),
      body: Center(
        child:  Image.asset("img/images.jpg")
      ),

    );
  }
}
