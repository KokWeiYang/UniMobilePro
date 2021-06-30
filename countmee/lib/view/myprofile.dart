import 'dart:convert';

import 'package:countmee/model/user.dart';
import 'package:countmee/view/editprofile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'mainscreen.dart';

class MyProfile extends StatefulWidget {
  final User user;

  const MyProfile({Key key, this.user}) : super(key: key);
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  // TextEditingController _emailController = new TextEditingController();
  double screenHeight, screenWidth;
  List _userlist;

  @override
  void initState() {
    super.initState();
    _loaduser();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xbbb898f2),
      appBar: AppBar(
        backgroundColor: Color(0xddd3c1f0),
        title: Text('My Profile'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => MainScreen()));
          },
          child: Icon(
            Icons.arrow_back_outlined,
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfiles(
                                user: widget.user,
                              )));
                },
                child: Icon(Icons.edit),
              )),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            _userlist == null
                ? Flexible(child: Text(""))
                : Flexible(
                    child: Center(
                      child: GridView.count(
                        crossAxisCount: 1,
                        childAspectRatio: (screenWidth / (screenHeight /1.49)),
                        children: List.generate(
                          _userlist.length,
                          (index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(5, 6, 5, 6),
                              child: Row(
                                children: [
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                            height: screenHeight / 25),
                                        Row(
                                          children: [
                                            Container(
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child: Text("E-mail : "),
                                            ),
                                            Container(
                                              color: Color(0xddd3c1f0),
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child: Text(
                                                  widget.user.email),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: screenHeight / 22),
                                        Row(
                                          children: [
                                            Container(
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child:
                                                  Text("First name : "),
                                            ),
                                            Container(
                                              color: Color(0xddd3c1f0),
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child: Text(
                                                  _userlist[index]
                                                      ['profname']),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: screenHeight / 22),
                                        Row(
                                          children: [
                                            Container(
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child:
                                                  Text("Last name : "),
                                            ),
                                            Container(
                                              color: Color(0xddd3c1f0),
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child: Text(
                                                  _userlist[index]
                                                      ['prolname']),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: screenHeight / 22),
                                        Row(
                                          children: [
                                            Container(
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child:
                                                  Text("Address 1 : "),
                                            ),
                                            Container(
                                              color: Color(0xddd3c1f0),
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child: Text(
                                                  _userlist[index]
                                                      ['proadd1']),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: screenHeight / 22),
                                        Row(
                                          children: [
                                            Container(
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child:
                                                  Text("Address 2 : "),
                                            ),
                                            Container(
                                              color: Color(0xddd3c1f0),
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child: Text(
                                                  _userlist[index]
                                                      ['proadd2']),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: screenHeight / 22),
                                        Row(
                                          children: [
                                            Container(
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child:
                                                  Text("Postcode : "),
                                            ),
                                            Container(
                                              color: Color(0xddd3c1f0),
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child: Text(
                                                  _userlist[index]
                                                      ['propostc']),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: screenHeight / 22),
                                        Row(
                                          children: [
                                            Container(
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child: Text("City : "),
                                            ),
                                            Container(
                                              color: Color(0xddd3c1f0),
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child: Text(
                                                  _userlist[index]
                                                      ['procity']),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: screenHeight / 22),
                                        Row(
                                          children: [
                                            Container(
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child: Text("State : "),
                                            ),
                                            Container(
                                              color: Color(0xddd3c1f0),
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child: Text(
                                                  _userlist[index]
                                                      ['prostate']),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: screenHeight / 22),
                                        Row(
                                          children: [
                                            Container(
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child: Text(
                                                  "Phone number : "),
                                            ),
                                            Container(
                                              color: Color(0xddd3c1f0),
                                              width: (screenWidth *
                                                      0.950) /
                                                  2,
                                              child: Text(
                                                  _userlist[index]
                                                      ['prophone']),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  void _loaduser() {
    String _email = widget.user.email;
    http.post(
        Uri.parse("https://hubbuddies.com/269971/countmee/php/load_user.php"),
        body: {
          "email": _email,
        }).then((response) {
      print(response);
      if (response.body == "nodata") {
        _userlist = [];
        return;
      } else {
        var jsondata = json.decode(response.body);
        _userlist = jsondata["users"];
        // print(_userlist);
      }
      setState(() {});
    });
  }
}
