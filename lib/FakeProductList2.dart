import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class FakeProductList2 extends StatefulWidget {
  const FakeProductList2({Key? key}) : super(key: key);

  @override
  State<FakeProductList2> createState() => _FakeProductList2State();
}

class _FakeProductList2State extends State<FakeProductList2> {
  Future<List>? alldata;

  Future<List> getdata()async{
     Uri url = Uri.parse("https://fakestoreapi.com/users");
     var response = await http.get(url);
     if(response.statusCode==200)
       {
         var body = response.body.toString();
         var json = jsonDecode(body);
         return json;
       }
     else
       {
         return [];
       }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata = getdata();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text ("FACK PRODUCT LIST-2"),
      ),
      body: FutureBuilder(
        future: alldata,
        builder: (context,snapshots)
          {
            if(snapshots.hasData)
              {
                if(snapshots.data!.length<=0)
                  {
                    return Center(
                      child: Text("NO PRODUCTS FOUND"),
                    );
                  }
                else
                  {
                    return ListView.builder(
                        itemCount: snapshots.data!.length,
                        itemBuilder: (context,index)
                        {
                          return  Container(
                            margin: EdgeInsets.all(10.0),
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Text(snapshots.data![index]["id"].toString()),
                                      ],
                                    ),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(snapshots.data![index]["name"]["firstname"].toString()),
                                            Text(snapshots.data![index]["name"]["lastname"].toString()),
                                          ],
                                        ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshots.data![index]["username"].toString()),
                                        Text(snapshots.data![index]["email"].toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(snapshots.data![index]["phone"].toString()),
                                        Text(snapshots.data![index]["password"].toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(snapshots.data![index]["address"]["geolocation"]["lat"].toString()),
                                        Text("," +snapshots.data![index]["address"]["geolocation"]["long"].toString()),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(snapshots.data![index]["address"]["city"].toString()),
                                        Text("," +snapshots.data![index]["address"]["street"].toString()),
                                        Text("," +snapshots.data![index]["address"]["number"].toString()),
                                        Text("," +snapshots.data![index]["address"]["zipcode"].toString()),
                                      ],
                                    ),
                                ],
                                ),
                              ),
                            ),
                          );
                        }
                    );
                  }
              }
            else
              {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          }
      ),
    );
  }
}
