import 'package:flutter/material.dart';

class Viewfackproduct extends StatefulWidget {
  var image ="";
  var title="";
  var category ="";
  var rating ="";
  Viewfackproduct({required this.image,required this.title,required this.category,required this.rating});

  @override
  State<Viewfackproduct> createState() => _ViewfackproductState();
}

class _ViewfackproductState extends State<Viewfackproduct> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("view fack product"),
      ),
      body: SingleChildScrollView(
        child:Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(40.0),
          child: Column(
            children: [
              Image.network(widget.image,height: 400,width: 400,),
              SizedBox(height: 10.0,),
              Text(widget.title,style: TextStyle(fontWeight: FontWeight.w900,fontSize: 25.0,),),
              SizedBox(height: 10.0,),
              Text(widget.category,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w600,color: Colors.grey),),
              SizedBox(height: 10.0,),
              Text(widget.rating,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20.0,color: Colors.grey),),

            ],
          ),
        ),
      )
    );
  }
}
