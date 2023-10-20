import 'dart:convert';

import 'package:apiproject/Productlist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Editproduct extends StatefulWidget {
  
  var pid="";
  Editproduct({required this.pid});

  @override
  State<Editproduct> createState() => _EditproductState();
}

class _EditproductState extends State<Editproduct> {

  TextEditingController _name =TextEditingController();
  TextEditingController _qty =TextEditingController();
  TextEditingController _price =TextEditingController();
  var isloading=false;
  
  getdata() async
  {
    setState(() {
      isloading=true;
    });
    Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/getSingleProduct.php");
    var params = {
      "pid":widget.pid
    };

    var response = await http.post(url,body: params);
    if(response.statusCode==200)
      {
        var json = jsonDecode(response.body.toString());
        _name.text = json["data"]["pname"].toString();
        _qty.text = json["data"]["qty"].toString();
        _price.text = json["data"]["price"].toString();
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
        title: Text("EDIT PRODUCT"),
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
              fillColor: Colors.green.shade900,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
            ),
            controller: _name,
            keyboardType: TextInputType.text,
          ),
          SizedBox(height: 15.0,),
          Text("QUNTITY",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800),),
          SizedBox(height: 15.0,),
          TextField(
            decoration: new InputDecoration(
              labelText: "ENTER QUNTITY",
              fillColor: Colors.green.shade900,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
            ),
            controller: _qty,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 15.0,),
          Text("PRICE",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w800)),
          SizedBox(height: 15.0,),
          TextField(
            decoration: new InputDecoration(
              labelText: "ENTER PRICE",
              fillColor: Colors.green.shade900,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
            ),
            controller: _price,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 15.0,),
            ElevatedButton(onPressed: () async{


              var nm = _name.text.toString();
              var qty = _price.text.toString();
              var price = _qty.text.toString();


              Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/updateProductNormal.php");

              var params = {
                "pname":nm,
                "qty":qty,
                "price":price,
                "pid":widget.pid
              };

              var response = await http.post(url,body: params);
              if(response.statusCode==200)
              {
                var json = jsonDecode(response.body.toString());
                if(json["status"]=="true")
                {
                    Navigator.of(context).pop(); //edit
                    Navigator.of(context).pop(); //view
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>Productlist())
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
