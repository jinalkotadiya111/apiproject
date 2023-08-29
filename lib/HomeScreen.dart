import 'package:apiproject/FakeProductList2.dart';
import 'package:apiproject/FakeProductList.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HOME SCREEN"),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            ListTile(
              title: Text("FAKE PRODUCT LIST",),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>FakeProductList())
                );
              },
            ),
            ListTile(
              title: Text("FACK PRODUCT LIST-2"),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>FakeProductList2()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
