import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/Social.dart';

class Socialcomunitylist2 extends StatefulWidget {
  const Socialcomunitylist2({Key? key}) : super(key: key);

  @override
  State<Socialcomunitylist2> createState() => _Socialcomunitylist2State();
}

class _Socialcomunitylist2State extends State<Socialcomunitylist2> {

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
        title: Text("SOCIAL COMUNITY LIST-2"),
      ),
      body: (alldata==null)?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: alldata!.length,
        itemBuilder: (context,index)
        {
          DateTime dateTime = DateTime.parse(alldata![index].date.toString());
          var formattedDate = DateFormat('dd.MM.yyyy').format(dateTime);

          String colorString = alldata![index].color.toString();
          Color cardColor = Color(int.parse(colorString.replaceAll("#", "0xff")));


          return  Card(
            margin: EdgeInsets.all(10.0),
            color: cardColor,
                child:Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(alldata![index].userName.toString(), style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0
                            ),),
                            SizedBox(height: 10.0,),
                            Text(alldata![index].gratitude.toString(), style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0
                            ),),
                          ],
                        ),),
                        ),
                        Column(
                          children: [
                            SizedBox(height: 5.0,),
                            Text(formattedDate,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0
                            ),),
                            SizedBox(height: 5.0,),
                            Image.network(alldata![index].categoryImage.toString(),width: 100.0),
                            SizedBox(height: 5.0,),
                          ],
                        ),
                      ],
                    )
                  ],
                          ),
          );
        },
      ),
    );
  }
}
