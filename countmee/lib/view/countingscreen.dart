import 'package:countmee/counting/addexpanse.dart';
import 'package:countmee/counting/hignlightwell.dart';
import 'package:countmee/counting/mybill.dart';
import 'package:countmee/counting/mychart.dart';
import 'package:countmee/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'mainscreen.dart';

class CountingScreen extends StatefulWidget {
  final User user;
 final int curtab;
  const CountingScreen({Key key, this.user, this.curtab}) : super(key: key);
  @override
  _CountingScreenState createState() => _CountingScreenState();
}

class _CountingScreenState extends State<CountingScreen> {
  int currentIndex  = 0;
  double screenHeight, screenWidth;
  String maintitle = "Bill";

   List<Widget> barchildren;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.curtab;
    barchildren = [
      MyBill(user: widget.user),
      AddExpanse(user: widget.user),
      Chart(user: widget.user)
    ];
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xddd3c1f0),
      appBar: AppBar(
        backgroundColor: Color(0xbbb898f2),
        title: Text(maintitle),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
                context, MaterialPageRoute(builder: (context) => MainScreen()));
          },
          child: Icon(
            Icons.arrow_back_outlined,
          ),
        ),
        
      ),
      body: barchildren[currentIndex],
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildBottomItem(0, 'Bill', Icons.description),
            _buildBottomItem(1, 'Bookkeeping', null),
            _buildBottomItem(2, 'Chart', Icons.pie_chart),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      if (currentIndex == 0) {
        maintitle = "Bill";
      }
      if (currentIndex == 1) {
        maintitle = "Add Expanse";
      }
      if (currentIndex == 2) {
        maintitle = "Chart";
      }
    });
  }


  _buildBottomItem(int index, String title, IconData data) {
    TextStyle textStyle = TextStyle(fontSize: 12.0, color: Colors.grey);
    TextStyle selectedTextStyle =
        TextStyle(fontSize: 12.0, color: Colors.black);
    Color iconColor = Colors.grey;
    Color selectedIconColor = Colors.black;
    double iconSize = 25;

    return data != null
        ? Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                if (index != currentIndex) {
                  onTabTapped(index);
                }
              },
              child: Container(
                height: 49,
                padding: const EdgeInsets.only(top: 5.5),
                child: Column(
                  children: <Widget>[
                    Icon(
                      data,
                      size: iconSize,
                      color: currentIndex == index
                          ? selectedIconColor
                          : iconColor,
                    ),
                    Text(
                      title,
                      style: currentIndex == index
                          ? selectedTextStyle
                          : textStyle,
                    )
                  ],
                ),
              ),
            ),
          )
        : Expanded(
            flex: 1,
            child: Container(
              height: 49,
              child: OverflowBox(
                minHeight: 49,
                maxHeight: 80,
                child: GestureDetector(
                  onTap: () {
                          Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddExpanse()),
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48 / 2),
                            border: Border.all(width: 2, color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.lime,
                                  blurRadius: 0,
                                  offset: Offset(0, -1)),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AddExpanse()),
                              );
                            },
                            child: SizedBox(
                              width: 44,
                              height: 44,
                              child: CircleAvatar(
                                backgroundColor: Color(0xff1d1d1d),
                                child:
                                    const Icon(Icons.add, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 17,
                        child: Text(
                          title,
                          style: TextStyle(color: Colors.black,fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
