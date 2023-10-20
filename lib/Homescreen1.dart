import 'package:apiproject/LoginScreen.dart';
import 'package:apiproject/Loginscreen1.dart';
import 'package:apiproject/Socialcomunitylist.dart';
import 'package:apiproject/Socialcomunitylist2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen1 extends StatefulWidget {
  const Homescreen1({Key? key}) : super(key: key);

  @override
  State<Homescreen1> createState() => _Homescreen1State();
}

class _Homescreen1State extends State<Homescreen1> {

  var name ="";
  var id = "";
  var user_session_token = "";
  var category_image ="";

  getdata()async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name").toString();
      id = prefs.getString("id").toString();
      user_session_token = prefs.getString("user_session_token").toString();
      category_image = prefs.getString("category_image").toString();
    });
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
        title: Text("HOME SCREEN"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile (
              title: Text("LOG OUT"),
              onTap: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();

                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>Loginscreen1())
                );
              },
            ),
            ListTile(
              title: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                child:Center(
                  child: Text("Welcome to Home Screen..",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w900,color: Colors.black),),
                ),
                decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border.all(color: Colors.blue.shade200,),
                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
            ),
            ListTile(
              title:  Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                child:Text("Name: "+name),
                decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    border: Border.all(color: Colors.red.shade200,),
                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
            ),
            ListTile(
              title:  Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                child:Text("id: "+id),
                decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    border: Border.all(color: Colors.red.shade200,),
                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
            ),
            ListTile(
              title:  Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                child:Text("user_session_token: "+user_session_token),
                decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    border: Border.all(color: Colors.red.shade200,),
                    borderRadius: BorderRadius.circular(10.0)
                ),
              ),
              ),
            ListTile(
              title: Text("SOCIAL COMUNITY LIST",),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=> Socialcomunitylist())
                );
              },
            ),
            ListTile(
              title: Text("SOCIAL COMUNITY LIST-2",),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=> Socialcomunitylist2())
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
