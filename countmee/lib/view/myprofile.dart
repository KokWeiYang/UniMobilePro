import 'package:countmee/model/user.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  final User user;

  const MyProfile({Key key, this.user}) : super(key: key);
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xbbb898f2),
      appBar: AppBar(
        backgroundColor: Color(0xddd3c1f0),
        title: Text('My Profile'),
      ),
      body: Center(
        child: Column(
          children: [Text('Hello World')],
        ),
      ),
    );
  }
}
