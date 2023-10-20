import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {

  TextEditingController _name =TextEditingController();
  TextEditingController _salary =TextEditingController();

  var gender="M";
  var selected = "Parchase";

  handleradio(val)
  {
    setState(() {
      gender=val!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ADD EMPLOYEE"),
      ),
      body: SingleChildScrollView(
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
            ElevatedButton(onPressed: () async{
              var nm = _name.text.toString();
              var sal = _salary.text.toString();
              var  dept = selected.toString();
              var gen = gender.toString();

              Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/insertEmployeeNormal.php");

              var parms = {
                "ename":nm,
                "salary":sal,
                "department":dept,
                "gender":gen,

              };

              var response = await http.post(url,body: parms);
              if(response.statusCode==200)
                {
                  var json = jsonDecode(response.body.toString());
                  if(json["status"]=="true")
                    {
                      var message = json["message"].toString();
                      var snackbar = SnackBar(
                        content: Text(message),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      _name.text ="";
                      _salary.text ="";


                     setState(() {
                        gender="M";
                        selected = "Parchase";
                     });

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

            },
                child: Text("ADD"))

          ],
        ),
      ),
    );
  }
}
//.MainActivity