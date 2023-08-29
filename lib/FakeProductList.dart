
import 'dart:convert';

import 'package:apiproject/Viewfackproduct.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class FakeProductList extends StatefulWidget {
  const FakeProductList({Key? key}) : super(key: key);

  @override
  State<FakeProductList> createState() => _FakeProductListState();
}

class _FakeProductListState extends State<FakeProductList> {

  Future<List>? alldata;

  //200 OK
  //400 Not Found
  //500 Server Error

  Future<List> getdata() async
  {
    Uri url = Uri.parse("https://fakestoreapi.com/products");
    var response = await http.get(url);
    if(response.statusCode==200)
      {
        var body = response.body.toString();
        print(body);
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
        title: Text("Products"),
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
                    child: Text("No Products found"),
                  );
                }
              else
                {
                  return ListView.builder(
                    itemCount: snapshots.data!.length,
                    itemBuilder: (context,index)
                    {
                      return GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>Viewfackproduct(
                              image: snapshots.data![index]["image"].toString(),
                              title: snapshots.data![index]["title"].toString(),
                                category:snapshots.data![index]["category"].toString(),
                                rating:"Rs." + snapshots.data![index]["rating"]["rate"].toString(),

                            ))
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10.0),
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.network(snapshots.data![index]["image"].toString(),width: 100.0,),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(snapshots.data![index]["title"].toString(),style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w900
                                          ),),
                                          Text(snapshots.data![index]["category"].toString()),
                                          Text("Rs." + snapshots.data![index]["rating"]["rate"].toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
            }
          else
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
        },
      ),
    );
  }
}
