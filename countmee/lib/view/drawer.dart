import 'package:countmee/model/user.dart';
import 'package:countmee/view/myprofile.dart';
import 'package:flutter/material.dart';
import 'loginscreen.dart';
import 'mainscreen.dart';

class MyDrawer extends StatefulWidget {
  final User user;

  const MyDrawer({Key key, this.user}) : super(key: key);
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          decoration: BoxDecoration(color: const Color(0xff7d57ae)),
          accountName: Text("Hi " + widget.user.name + ","),
          accountEmail: Text(widget.user.email),
          currentAccountPicture: CircleAvatar(
            // foregroundImage:,
            backgroundColor:
                Theme.of(context).platform == TargetPlatform.android
                    ? Colors.white
                    : Colors.red,
            child: Text(
              widget.user.email.toString().substring(0, 1).toUpperCase(),
              style: TextStyle(fontSize: 40),
            ),
          ),
        ),
        ListTile(
            title: Text("My Menu"),
            onTap: () {
              Navigator.pop(
                  context,
                  MaterialPageRoute(
                      builder: (content) => MainScreen(
                            user: widget.user,
                          )));
            }),
        ListTile(
            title: Text("My Counting"),
            onTap: () {
              Navigator.pop(context);
            }),
        ListTile(
            title: Text("My Notice"),
            onTap: () {
              Navigator.pop(context);
            }),
        ListTile(
            title: Text("My Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (content) => MyProfile(
                            user: widget.user,
                          )));
            }),
        ListTile(
            title: Text("Logout"),
            onTap: () {
              showlogout();
            })
      ],
    ));
  }

  void showlogout() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Logout?',
          style: TextStyle(),
        ),
        content: new Text(
          'Are you sure?',
          style: TextStyle(),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context,
                    MaterialPageRoute(builder: (content) => LoginScreen()));
              },
              child: Text(
                "Yes",
                style: TextStyle(),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "No",
                style: TextStyle(),
              )),
        ],
      ),
    );
  }
}
