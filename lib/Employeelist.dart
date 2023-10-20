import 'dart:convert';

import 'package:apiproject/Addemployee2.dart';
import 'package:apiproject/Editemployee.dart';
import 'package:apiproject/models/Employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;


class Employeelist extends StatefulWidget {
  const Employeelist({Key? key}) : super(key: key);

  @override
  State<Employeelist> createState() => _EmployeelistState();
}

class _EmployeelistState extends State<Employeelist> {

  List<Employee>? alldata;
  var isloading=false;

  getdata()async{
    Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/getEmployee.php");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);

      setState(() {
        alldata = json["data"].map<Employee>((obj)=>Employee.fromJson(obj)).toList();
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
        title: Text("EMPLOYEE LIST"),
      ),
      body: (alldata==null || isloading)?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: alldata!.length,
          itemBuilder: (context,index)
          {
            return Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(alldata![index].ename.toString()),
                      Text(alldata![index].salary.toString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(alldata![index].department.toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(alldata![index].gender.toString()),
                      ElevatedButton(onPressed: ()async{
                        setState(() {

                          isloading = true;
                        });
                        
                        var eid = alldata![index].eid.toString();
                        
                        Uri url =Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/deleteEmployeeNormal.php");
                        var parms ={
                          "eid":eid
                        };
                        var response = await http.post(url,body: parms);

                        if(response.statusCode==200)
                        {
                          var json = jsonDecode(response.body.toString());
                          if(json["status"]=="true")
                          {
                            var message = json["message"].toString();
                            getdata();
                            setState(() {
                              isloading = false;
                            });
                          }
                        }

                      }, child: Text("DELETE")),

                      ElevatedButton(onPressed: (){

                        var eid = alldata![index].eid.toString();

                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>Editemployee(
                            eid:eid,
                          ))
                        );
                      }, child: Text("UPDATE")),
                      ElevatedButton(onPressed: (){

                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=> Addemployee2())
                        );
                      }, child: Text("UPDATE-2"))
                    ],
                  ),
                ],
              ),
                    decoration: BoxDecoration(
                       color: Colors.blue.shade50,
                       border: Border.all(color: Colors.blue.shade200,),
                       borderRadius: BorderRadius.circular(10.0)
                    ),
            );
          }
      ),
    );
  }
}
