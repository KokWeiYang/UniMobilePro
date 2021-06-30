import 'package:countmee/model/food.dart';
import 'package:flutter/material.dart';
 
class DetailFood extends StatefulWidget {
  final Food food;

  const DetailFood({Key key, this.food}) : super(key: key);
  @override
  _DetailFoodState createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text(widget.food.id),
          ),
        ),
      ),
    );
  }
}