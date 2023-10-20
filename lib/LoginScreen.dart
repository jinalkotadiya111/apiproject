import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
            ElevatedButton(onPressed: () async{

              var username = _username.text.toString();
              var password = _password.text.toString();

              Uri url = Uri.parse("https://begratefulapp.ca/api/login");

              var params = {
                "name": username,
                "password":password,
                "device_token":"12345678",
                "device_os":"android"
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
                    var message = json["message"].toString();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message,style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,)
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


            }, child: Text("SUBMITE"))
          ],
        ),
      ),
    );
  }
}
