import 'dart:convert';

import 'package:apiproject/Addproduct2.dart';
import 'package:apiproject/Editproduct.dart';
import 'package:apiproject/models/Product.dart';
import 'package:apiproject/models/Products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class Productlist extends StatefulWidget {
  const Productlist({Key? key}) : super(key: key);

  @override
  State<Productlist> createState() => _ProductlistState();
}

class _ProductlistState extends State<Productlist> {

 List<Products>? alldata;

  var isloading=false;



  getdata() async{
    Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/getProducts.php");
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        var json = jsonDecode(body);

        setState(() {
          alldata = json["data"].map<Products>((obj)=>Products.fromJson(obj)).toList();
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
        title: Text("PRODUCT LIST"),
      ),
      body: (alldata==null || isloading)?Center(child: CircularProgressIndicator(),):ListView.builder(
        itemCount: alldata!.length,
          itemBuilder: (context,index) {
            return Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Column(
                   children: [ Text(alldata![index].pname.toString()),],
                 ),
                  Column(
                    children: [Text(alldata![index].price.toString()),
                      Text(alldata![index].qty.toString()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(onPressed: () async{

                            setState(() {

                              isloading = true;
                            });
                            var pid  = alldata![index].pid.toString();

                            Uri url = Uri.parse("https://elastic-ishizaka.217-174-245-235.plesk.page/studentapi/deleteProductNormal.php");
                            var params = {
                              "pid":pid
                            };

                            var response = await http.post(url,body: params);

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


                          }, child: Text("Delete")),
                          SizedBox(width: 10.0,),


                          ElevatedButton(onPressed: (){
                            var pid  = alldata![index].pid.toString();

                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>Editproduct(
                                pid: pid,
                              ))
                            );
                          }, child: Text("UPDATE")),
                          SizedBox(width: 10.0,),

                          ElevatedButton(onPressed: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=> Addproduct2(
                                obj: alldata![index],
                              ))
                            );

                          }, child: Text("UPDATE-2"))
                        ],
                      )
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  border: Border.all(color: Colors.red.shade200,),
                  borderRadius: BorderRadius.circular(10.0)
              ),
            );
          },
      ),
    );
  }
}
