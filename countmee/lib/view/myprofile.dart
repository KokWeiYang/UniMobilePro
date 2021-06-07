import 'package:countmee/model/user.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  final User user;

  const MyProfile({Key key, this.user}) : super(key: key);
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  // TextEditingController _emailController = new TextEditingController();
  double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xbbb898f2),
      appBar: AppBar(
        backgroundColor: Color(0xddd3c1f0),
        title: Text('My Profile'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: screenHeight / 25),
                      Row(
                        children: [
                          Container(
                            width: screenWidth / 2,
                            child: Text("E-mail : "),
                          ),
                          Container(
                            color: Color(0xddd3c1f0),
                            width: screenWidth / 2,
                            child: Text(widget.user.email),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight / 22),
                      Row(
                        children: [
                          Container(
                            width: screenWidth / 2,
                            child: Text("First name : "),
                          ),
                          Container(
                            color: Color(0xddd3c1f0),
                            width: screenWidth / 2,
                            child: Text(widget.user.fname),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight / 22),
                      Row(
                        children: [
                          Container(
                            width: screenWidth / 2,
                            child: Text("Last name : "),
                          ),
                          Container(
                            color: Color(0xddd3c1f0),
                            width: screenWidth / 2,
                            child: Text(widget.user.lname),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight / 22),
                      Row(
                        children: [
                          Container(
                            width: screenWidth / 2,
                            child: Text("Address 1 : "),
                          ),
                          Container(
                            color: Color(0xddd3c1f0),
                            width: screenWidth / 2,
                            child: Text(widget.user.address),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight / 22),
                      Row(
                        children: [
                          Container(
                            width: screenWidth / 2,
                            child: Text("Address 2 : "),
                          ),
                          Container(
                            color: Color(0xddd3c1f0),
                            width: screenWidth / 2,
                            child: Text(widget.user.address2),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight / 22),
                      Row(
                        children: [
                          Container(
                            width: screenWidth / 2,
                            child: Text("Postcode : "),
                          ),
                          Container(
                            color: Color(0xddd3c1f0),
                            width: screenWidth / 2,
                            child: Text(widget.user.postcode),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight / 22),
                      Row(
                        children: [
                          Container(
                            width: screenWidth / 2,
                            child: Text("City : "),
                          ),
                          Container(
                            color: Color(0xddd3c1f0),
                            width: screenWidth / 2,
                            child: Text(widget.user.city),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight / 22),
                      Row(
                        children: [
                          Container(
                            width: screenWidth / 2,
                            child: Text("State : "),
                          ),
                          Container(
                            color: Color(0xddd3c1f0),
                            width: screenWidth / 2,
                            child: Text(widget.user.state),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight / 22),
                      Row(
                        children: [
                          Container(
                            width: screenWidth / 2,
                            child: Text("Phone number : "),
                          ),
                          Container(
                            color: Color(0xddd3c1f0),
                            width: screenWidth / 2,
                            child: Text(widget.user.phonenum),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
