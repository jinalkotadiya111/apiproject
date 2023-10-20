import 'dart:convert';
import 'dart:io';

import 'package:apiproject/Homescreen1.dart';
import 'package:apiproject/Ragisterscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Loginscreen1 extends StatefulWidget {
  const Loginscreen1({Key? key}) : super(key: key);

  @override
  State<Loginscreen1> createState() => _Loginscreen1State();
}

class _Loginscreen1State extends State<Loginscreen1> {

  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN SCREEN"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text("NAME",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800),),
            SizedBox(height: 15.0,),
            TextField(
              controller: _username,
              decoration: new InputDecoration(
                labelText: "ENTER NAME",
                fillColor: Colors.green.shade900,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 15.0,),
            Text("PASSWORD",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800),),
            SizedBox(height: 15.0,),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: new InputDecoration(
                labelText: "ENTER PASSWORD",
                fillColor: Colors.green.shade900,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(25.0),
                  borderSide: new BorderSide(),
                ),
              ),
            ),
            SizedBox(height: 15.0,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               ElevatedButton(onPressed: ()async{

                 var username = _username.text.toString();
                 var password = _password.text.toString();


                 Uri url = Uri.parse("https://begratefulapp.ca/api/login");

                 SharedPreferences prefs = await SharedPreferences.getInstance();
                 String os = Platform.operatingSystem;


                 var params = {
                   "name": username,
                   "password":password,
                   "device_token":prefs.getString("token"),
                   "device_os":os
                 };

                 var hed = {
                   "Content-Type":"application/json"
                 };

                 var response = await http.post(url,body: jsonEncode(params),headers: hed);
                 if(response.statusCode==200)
                 {
                   var json = jsonDecode(response.body);
                   if(json["result"]=="success")
                   {
                     var id = json["data"]["id"].toString();
                     var name = json["data"]["name"].toString();
                     var user_session_token = json["data"]["user_session_token"].toString();
                     var gratitude = json["data"]["gratitude"].toString();
                     var date = json["data"]["date"].toString();
                     var category_image = json["data"]["category_image"].toString();
                     var color = json["data"]["color"].toString();

                     SharedPreferences prefs = await SharedPreferences.getInstance();
                     prefs.setString("islogin", "yes");

                     prefs.setString("name" ,name);
                     prefs.setString("id", id);
                     prefs.setString("user_session_token", user_session_token);
                     prefs.setString("gratitude", gratitude);
                     prefs.setString("date", date);
                     prefs.setString("category_image", category_image);
                     prefs.setString("color",color);



                     var message = json["message"].toString();
                     ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text(message,style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,)
                     );
                     Navigator.of(context).pop();
                     Navigator.of(context).push(
                         MaterialPageRoute(builder: (context)=>Homescreen1())
                     );
                   }
                   else
                   {
                     var message = json["message"].toString();
                     ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text(message,style: TextStyle(color: Colors.white),),backgroundColor: Colors.red,)
                     );
                   }
                 }

               }, child: Text("SUBMITE")),

               ElevatedButton(onPressed: (){

                 Navigator.of(context).pop();
                 Navigator.of(context).push(
                     MaterialPageRoute(builder: (context)=>Ragisterscreen())
                 );

               }, child: Text("Ragister screen"))
             ],
           ),
          ],
        ),
      ),
    );
  }
}
