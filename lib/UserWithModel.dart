
import 'package:apiproject/UserDetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'dart:convert';
import 'models/User.dart';

class UserWithModel extends StatefulWidget {
  const UserWithModel({Key? key}) : super(key: key);

  @override
  State<UserWithModel> createState() => _UserWithModel();
}

class _UserWithModel extends State<UserWithModel> {

  List<user>? alldata;

  getdata()async{
    Uri url = Uri.parse("https://fakestoreapi.com/users");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);

      setState(() {
        alldata = json.map<user>((obj)=>user.fromJson(obj)).toList();
      });

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
      appBar:AppBar(
        title: Text("with model"),
      ),
      body: (alldata==null)?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: alldata!.length,
        itemBuilder:(context,index)
        {
          return ListTile(
            title: Text(alldata![index].name!.firstname.toString()),
            subtitle: Text(alldata![index].username.toString()),
            leading:  ElevatedButton(
                onPressed:(){

                },
                child: Text("DELETE")),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>UserDetail(obj: alldata![index],)),
              );

            },

          );
        },

      ),
    );
  }
}
