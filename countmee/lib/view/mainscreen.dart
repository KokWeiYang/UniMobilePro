import 'package:countmee/model/user.dart';
import 'package:flutter/material.dart';
import 'drawer.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: MyDrawer(user: widget.user),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}