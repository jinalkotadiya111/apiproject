import 'package:apiproject/AddEmployee.dart';
import 'package:apiproject/AddProduct.dart';
import 'package:apiproject/Employeelist.dart';
import 'package:apiproject/FakeProductList2.dart';
import 'package:apiproject/FakeProductList.dart';
import 'package:apiproject/LoginScreen.dart';
import 'package:apiproject/Productlist.dart';
import 'package:apiproject/UserWithModel.dart';
import 'package:flutter/material.dart';

import 'FakeProductWithModel.dart';

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
              title: Text("LOGIN SCREEN",),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>LoginScreen())
                );
              },
            ),
            ListTile(
              title: Text("PRODUCT LIST",),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>Productlist())
                );
              },
            ),
            ListTile(
              title: Text("EMPOYEE LIST",),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>Employeelist())
                );
              },
            ),
            ListTile(
              title: Text("ADD EMPLOYEEE",),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>AddEmployee())
                );
              },
            ),
            ListTile(
              title: Text("ADD PRODUCT",),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>AddProduct())
                );
              },
            ),

            ListTile(
              title: Text("FAKE PRODUCT LIST MODEL",),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>FakeProductWithModel())
                );
              },
            ),
            ListTile(
              title: Text("USER MODEL",),
              trailing: Icon(Icons.arrow_forward_ios_outlined),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>UserWithModel())
                );
              },
            ),
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
