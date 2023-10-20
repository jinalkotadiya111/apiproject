import 'package:flutter/material.dart';

import 'models/User.dart';

class UserDetail extends StatefulWidget {
  user? obj;
  UserDetail({required this.obj});


  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[
            Text(widget.obj!.id.toString()),
            Text(widget.obj!.username.toString()),
            Text(widget.obj!.address.toString()),
            Text(widget.obj!.email.toString()),
            Text(widget.obj!.password.toString()),
            Text(widget.obj!.phone.toString()),
            Text(widget.obj!.iV.toString()),
],

        ),
      ),

    );
  }
}
