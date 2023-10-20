import 'package:flutter/material.dart';

class Addemployee2 extends StatefulWidget {
  const Addemployee2({Key? key}) : super(key: key);

  @override
  State<Addemployee2> createState() => _Addemployee2State();
}

class _Addemployee2State extends State<Addemployee2> {
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
        title: Text("UPDATE EMPLOYEE-2"),
      ),
      body: SingleChildScrollView(
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
            ElevatedButton(onPressed: (){

            }, child: Text("UPDATE-2"))
        ],
      ),
      ),
    );
  }
}
