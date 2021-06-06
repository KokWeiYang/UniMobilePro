import 'package:countmee/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'addmee.dart';
import 'drawer.dart';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

import 'loginscreen.dart';

class MainScreen extends StatefulWidget {
  final User user;

  const MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double screenHeight, screenWidth;
  List _productlist;
  @override
  void initState() {
    super.initState();
    _loadimage();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
          backgroundColor: Colors.deepPurple[300],
        ),
        drawer: MyDrawer(user: widget.user),
        body: Center(
          child: Column(
            children: [
              _productlist == null
                  ? Flexible(child: Center(child: Text('empty')))
                  : Flexible(
                      child: Center(
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio:
                              (screenWidth / (screenHeight / 1.05)),
                          children: List.generate(
                            _productlist.length,
                            (index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(5, 6, 5, 6),
                                child: GestureDetector(
                                  onTap: _detailprinfo,
                                  child: Card(
                                    color: Colors.deepOrange[50],
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 10),
                                          Container(
                                            height: screenWidth / 2.5,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "https://hubbuddies.com/269971/countmee/images/mee/${_productlist[index]['productid']}.png",
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  new Transform.scale(
                                                      scale: 0.5,
                                                      child:
                                                          CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      new Icon(
                                                Icons.broken_image,
                                                size: screenWidth / 2.5,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                            height: screenWidth / 3.7,
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      5, 1, 5, 1),
                                                  height: screenWidth / 4,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          _productlist[index]
                                                              ['productname'],
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Text("RM" +
                                                            _productlist[index][
                                                                'productprice1'] +
                                                            " /Small"),
                                                      ),
                                                      Container(
                                                        child: Text("RM" +
                                                            _productlist[index][
                                                                'productprice2'] +
                                                            " /Big"),
                                                      ),
                                                      Container(
                                                        // height: screenWidth / 5,
                                                        child: Text(
                                                          'Sell on: ' +
                                                              _productlist[
                                                                      index][
                                                                  'productsellday'],
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Color(0xaaad7cf9),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddMee()),
              );
            },
          ),
        ),
      ),
    );
  }

  void _loadimage() {
    http.post(
        Uri.parse("https://hubbuddies.com/269971/countmee/php/loadmees.php"),
        body: {}).then((response) {
      if (response.body == "nodata") {
        return;
      } else {
        var jsondata = json.decode(response.body);
        _productlist = jsondata["products"];
        setState(() {});
        print(_productlist);
      }
    });
  }

  Future<bool> _onBackPressed() {
    return showDialog(
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
        ) ??
        false;
  }

  void _detailprinfo() {
    
  }
}
