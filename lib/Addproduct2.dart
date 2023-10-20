import 'package:apiproject/models/Product.dart';
import 'package:flutter/material.dart';

import 'models/Products.dart';

class Addproduct2 extends StatefulWidget {
  Products obj;
  Addproduct2({required this.obj});

  @override
  State<Addproduct2> createState() => _Addproduct2State();
}

class _Addproduct2State extends State<Addproduct2> {


  TextEditingController _name =TextEditingController();
  TextEditingController _qty =TextEditingController();
  TextEditingController _price =TextEditingController();


  getdata() async
  {
    _name.text = widget.obj.pname.toString();
    _qty.text = widget.obj.qty.toString();
    _price.text = widget.obj.price.toString();
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
        title: Text("ADD PRODUCT -2"),
      ),
      body: SingleChildScrollView(
        child:  Column(
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
            ElevatedButton(onPressed: (){

            }, child: Text("update"))
        ],
      ),
      ),
    );
  }
}
