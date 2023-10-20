import 'package:apiproject/models/Product.dart';
import 'package:flutter/material.dart';

class Productdetail extends StatefulWidget {
  Product? obj;
  Productdetail({required this.obj});

  @override
  State<Productdetail> createState() => _ProductdetailState();
}

class _ProductdetailState extends State<Productdetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product detail"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(widget.obj!.title.toString()),
            Text(widget.obj!.category.toString()),
          ],
        ),
      ),
    );
  }
}
