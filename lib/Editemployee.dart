import 'dart:convert';

import 'package:apiproject/Employeelist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Editemployee extends StatefulWidget {

  var eid="";
  Editemployee({required this.eid});


  @override
  State<Editemployee> createState() => _EditemployeeState();
}

class _EditemployeeState extends State<Editemployee> {

  TextEditingController _name =TextEditingController();
  TextEditingController _salary =TextEditingController();
  var isloading=false;

  var gender="M";
  var selected = "Parchase";

  handleradio(val)
  {
    setState(() {
      gender=val!;
    });
  }

  getdata() async
  {
    setState(() {
      isloading=true;
    });
    Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/getSingleEmployee.php");
    var params = {
      "eid":widget.eid
    };

    var response = await http.post(url,body:params );
    if(response.statusCode == 200)
      {
        var json = jsonDecode(response.body.toString());
        _name.text = json["data"]["ename"].toString();
        _salary.text = json["data"]["salary"].toString();
        setState(() {
          selected = json["data"]["department"].toString();
          gender = json["data"]["gender"].toString();
        });
        setState(() {
          isloading=false;
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
      appBar: AppBar(
        title: Text("EDIT EMPLOYEE"),
      ),
    body: (isloading)?Center(child: CircularProgressIndicator(),):SingleChildScrollView(
             padding: EdgeInsets.all(10.0),
             child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("NAME",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800),),
                SizedBox(height: 15.0,),
                TextField(
                  decoration: new InputDecoration(
                    labelText: "ENTER NAME",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  controller: _name,
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 15.0,),
                Text("SALARY",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800),),
                SizedBox(height: 15.0,),
                TextField(
                  decoration: new InputDecoration(
                    labelText: "ENTER SALARY",
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  controller: _salary,
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 15.0,),
                Text("DEPARTMENT",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800),),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      onChanged: (val)
                      {
                        setState(() {
                          selected = val!;
                        });
                        },
                      value: selected,
                      items: [
                        DropdownMenuItem(
                          value: "Parchase",
                          child: Text("Parchase",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600),),
                        ),
                        DropdownMenuItem(
                          value: "Sale",
                          child: Text("Sale",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600),),
                        ),
                        DropdownMenuItem(
                          value: "Manager",
                          child: Text("Manager",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600),),
                        ),
                        DropdownMenuItem(
                          value: "Worker",
                          child: Text("Worker",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600),),
                        ),
                        DropdownMenuItem(
                          value: "service",
                          child: Text("service",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600),),
                        ),
                        DropdownMenuItem(
                          value: "Markting",
                          child: Text("Markting",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600),),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15.0,),
                Text("Gender",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800),),
                SizedBox(height: 15.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Radio(
                      groupValue: gender,
                      value: "M",
                      onChanged: handleradio,
                    ),
                    Text("Male",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600),),
                    Radio(
                        groupValue: gender,
                        value: "F",
                        onChanged: handleradio
                    ),
                    Text("Female",style: TextStyle(fontSize: 15.0,fontWeight: FontWeight.w600),),
                  ],),
                SizedBox(height: 15.0,),
                ElevatedButton(onPressed: ()async{
                  var nm = _name.text.toString();
                  var sal = _salary.text.toString();
                  var  dept = selected.toString();
                  var gen = gender.toString();

                  Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/updateEmployeeNormal.php");

                  var parms = {
                    "ename":nm,
                    "salary":sal,
                    "department":dept,
                    "gender":gen,
                    "eid":widget.eid,

                  };

                  var response = await http.post(url,body: parms);
                  if(response.statusCode==200)
                  {
                    var json = jsonDecode(response.body.toString());
                    if(json["status"]=="true")
                    {

                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>Employeelist())
                      );
                    }
                    else
                    {
                      var message = json["message"].toString();
                      var snackbar = SnackBar(
                        content: Text(message),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  }

                }, child: Text("UPDATE"))
              ],
             ),
    ),
    );
  }
}


