import 'dart:convert';

import 'package:apiproject/models/Social.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Socialcomunitylist extends StatefulWidget {
  const Socialcomunitylist({Key? key}) : super(key: key);

  @override
  State<Socialcomunitylist> createState() => _SocialcomunitylistState();
}

class _SocialcomunitylistState extends State<Socialcomunitylist> {


  List<Social>? alldata;
  
  getdata() async
  {
    Uri url = Uri.parse("https://begratefulapp.ca/api/social-community");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var params = {
      "user_id": prefs.getString("id").toString(),
      "page": "1"
    };
    var headers = {
      "user_session_token":prefs.getString("user_session_token").toString(),
      "Content-Type":"application/json"
    };


    var response  = await http.post(url,body: jsonEncode(params),headers: headers);
    if(response.statusCode==200)
      {
        var json = jsonDecode(response.body.toString());
        if(json["result"]=="success")
          {
            setState(() {
              alldata = json["data"].map<Social>((obj)=>Social.fromJson(obj)).toList();
            });
          }
        else
          {
            var message = json["message"].toString();
            //print
          }
      }

  }
  
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SOCIAL COMUNITY LIST"),
      ),
      body: (alldata==null)?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: alldata!.length,
        itemBuilder: (context,index)
        {
          return ListTile(
            title: Text(alldata![index].gratitude.toString()),
          );
        },
      ),
    );
  }
}
