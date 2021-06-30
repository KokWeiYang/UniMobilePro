import 'package:countmee/model/user.dart';
import 'package:flutter/material.dart';

class CountingScreen extends StatefulWidget {
  final User user;

  const CountingScreen({Key key, this.user}) : super(key: key);
  @override
  _CountingScreenState createState() => _CountingScreenState();
}

class _CountingScreenState extends State<CountingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Counting'),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Center(
        child: Container(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
