import 'package:apiproject/Productdetail.dart';
import 'package:apiproject/models/Product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';




class FakeProductWithModel extends StatefulWidget {
  const FakeProductWithModel({Key? key}) : super(key: key);

  @override
  State<FakeProductWithModel> createState() => _FakeProductWithModelState();
}

class _FakeProductWithModelState extends State<FakeProductWithModel> {



  List<Product>? alldata;

  getdata() async
  {
    Uri url = Uri.parse("https://fakestoreapi.com/products");
    var response = await http.get(url);
    if(response.statusCode==200)
    {
      var body = response.body.toString();
      var json = jsonDecode(body);

      // Json Loop
      // Loop first json object read
      // json object convert class object
      // alldata store

      setState(() {
        alldata = json.map<Product>((obj)=>Product.fromJson(obj)).toList();
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
        title: Text(("With Model")),
      ),
      body: (alldata==null)?Center(child: CircularProgressIndicator(),): ListView.builder(
        itemCount: alldata!.length,
        itemBuilder: (context,index)
        {
          return ListTile(
            title: Text(alldata![index].title.toString()),
            subtitle: Text(alldata![index].rating!.rate.toString()),
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context)=>Productdetail(obj: alldata![index],))
              );

            },
          );
        },
      ),
    );
  }
}
