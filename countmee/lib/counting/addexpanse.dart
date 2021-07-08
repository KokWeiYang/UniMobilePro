import 'package:countmee/view/countingscreen.dart';
import 'package:flutter/material.dart';
import 'package:countmee/counting/mybill.dart';
import 'package:countmee/model/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class AddExpanse extends StatefulWidget {
  final User user;
  final int curtab;
  const AddExpanse({Key key, this.user, this.curtab}) : super(key: key);
  @override
  _AddExpanseState createState() => _AddExpanseState();
}

class _AddExpanseState extends State<AddExpanse> {
  List<Widget> tbarchildren;
  String submitwhat = "";
  String type = "";
  int currentIndex = 0;
  ProgressDialog pr;
  double screenHeight, screenWidth;
  String _curTime;
  String _ouType = "none";
  double price = 0;
  bool isincome = false;
  TextEditingController btoutcome = new TextEditingController();
  TextEditingController btincome = new TextEditingController();
  TextEditingController bremark = new TextEditingController();
  TextEditingController intype = new TextEditingController();
  var date = new DateTime.now();
  @override
  void initState() {
    super.initState();
    _curTime =
        "${date.year.toString()}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ";
    print(_curTime);
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Income'),
    Tab(text: 'Outcome'),
  ];

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context);
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            setState(() {
              currentIndex = tabController.index;
            });
          }
        });
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Bookkeeping",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color(0xbbb898f2),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CountingScreen()));
                },
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
              bottom: const TabBar(
                tabs: tabs,
              ),
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: TabBarView(
                physics: new NeverScrollableScrollPhysics(),
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Container(
                          child: Column(children: [
                        Text(
                          "Information",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        Divider(height: 2, color: Colors.black),
                        SizedBox(height: 10),
                        Container(
                          height: screenHeight * 0.07,
                          width: screenWidth * 0.9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text("Income Type :"),
                              SizedBox(
                                width: 118,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white30,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  height: screenHeight * 0.08,
                                  width: screenWidth * 0.25,
                                  child: Center(
                                      child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: intype,
                                    decoration:
                                        InputDecoration(hintText: "       --"),
                                  )))
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: screenHeight * 0.07,
                          width: screenWidth * 0.9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text("Curent Date Time :"),
                              SizedBox(
                                width: 90,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white30,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  height: screenHeight * 0.08,
                                  width: screenWidth * 0.25,
                                  child: Center(child: Text(_curTime)))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: screenHeight * 0.07,
                          width: screenWidth * 0.9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text("Total Income :"),
                              SizedBox(
                                width: 114,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white30,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  height: screenHeight * 0.08,
                                  width: screenWidth * 0.25,
                                  child: Center(
                                      child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: btincome,
                                    decoration: InputDecoration(
                                        prefixText: "RM ", hintText: "--"),
                                  )))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: screenHeight * 0.07,
                          width: screenWidth * 0.9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black45),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text("Remark :"),
                              SizedBox(
                                width: 150,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white30,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  height: screenHeight * 0.08,
                                  width: screenWidth * 0.25,
                                  child: Center(
                                      child: TextField(
                                    keyboardType: TextInputType.number,
                                    controller: bremark,
                                    decoration: InputDecoration(
                                      hintText: "       --",
                                    ),
                                  )))
                            ],
                          ),
                        ),
                        SizedBox(height: 150),
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            minWidth: screenWidth,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Submit',
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            onPressed: _insubmitdialog,
                            color: Color(0xddd1b8f7)),
                      ])),
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(12, 20, 12, 5),
                                child: SingleChildScrollView(
                                    child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                            "Choose the Type of Bookkeeping",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Divider(height: 1, color: Colors.black),
                                      SizedBox(height: 15),
                                      Container(
                                        height: screenHeight * 0.29,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  SizedBox(height: 5),
                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _bookType("Noodle");
                                                        },
                                                        child: Container(
                                                          child: Center(
                                                              child: Text(
                                                            "Noodle",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                            ),
                                                          )),
                                                          height: screenHeight *
                                                              0.08,
                                                          width:
                                                              screenWidth * 0.2,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12))),
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black26,
                                                            width: 1.0),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _bookType(
                                                              "VegeMeats");
                                                        },
                                                        child: Container(
                                                          child: Center(
                                                              child: Text(
                                                            "VegeMeat",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                            ),
                                                          )),
                                                          height: screenHeight *
                                                              0.08,
                                                          width:
                                                              screenWidth * 0.2,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12))),
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black26,
                                                            width: 1.0),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _bookType("Curry");
                                                      },
                                                      child: Container(
                                                        child: Center(
                                                            child: Text(
                                                          "Curry",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black45,
                                                          ),
                                                        )),
                                                        height:
                                                            screenHeight * 0.08,
                                                        width:
                                                            screenWidth * 0.2,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12))),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              VerticalDivider(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _bookType("Sauces");
                                                        },
                                                        child: Container(
                                                          child: Center(
                                                              child: Text(
                                                            "Sauces",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                            ),
                                                          )),
                                                          height: screenHeight *
                                                              0.08,
                                                          width:
                                                              screenWidth * 0.2,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12))),
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black26,
                                                            width: 1.0),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _bookType(
                                                              "Vegetables");
                                                        },
                                                        child: Container(
                                                          child: Center(
                                                              child: Text(
                                                            "Vegetable",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                            ),
                                                          )),
                                                          height: screenHeight *
                                                              0.08,
                                                          width:
                                                              screenWidth * 0.2,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12))),
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black26,
                                                            width: 1.0),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _bookType("Eggs");
                                                      },
                                                      child: Container(
                                                        child: Center(
                                                            child: Text(
                                                          "Eggs",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black45,
                                                          ),
                                                        )),
                                                        height:
                                                            screenHeight * 0.08,
                                                        width:
                                                            screenWidth * 0.2,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12))),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              VerticalDivider(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _bookType("VegOil");
                                                        },
                                                        child: Container(
                                                          child: Center(
                                                              child: Text(
                                                            "VegOil",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                            ),
                                                          )),
                                                          height: screenHeight *
                                                              0.08,
                                                          width:
                                                              screenWidth * 0.2,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12))),
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black26,
                                                            width: 1.0),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _bookType(
                                                              "Seasoning");
                                                        },
                                                        child: Container(
                                                          child: Center(
                                                              child: Text(
                                                            "Seasoning",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                            ),
                                                          )),
                                                          height: screenHeight *
                                                              0.08,
                                                          width:
                                                              screenWidth * 0.2,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12))),
                                                        ),
                                                      ),
                                                    ),
                                                    decoration: BoxDecoration(
                                                      border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black26,
                                                            width: 1.0),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _bookType("Gas");
                                                      },
                                                      child: Container(
                                                        child: Center(
                                                            child: Text(
                                                          "Gas",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black45,
                                                          ),
                                                        )),
                                                        height:
                                                            screenHeight * 0.08,
                                                        width:
                                                            screenWidth * 0.2,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12))),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              VerticalDivider(
                                                color: Colors.black,
                                                width: 1,
                                              ),
                                              Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            _bookType("Rent");
                                                          },
                                                          child: Container(
                                                            child: Center(
                                                                child: Text(
                                                              "Rent",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black45,
                                                              ),
                                                            )),
                                                            height:
                                                                screenHeight *
                                                                    0.08,
                                                            width: screenWidth *
                                                                0.2,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12))),
                                                          ),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .black26,
                                                              width: 1.0),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            _bookType("Utility");
                                                          },
                                                          child: Container(
                                                            child: Center(
                                                                child: Text(
                                                              "Utility",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black45,
                                                              ),
                                                            )),
                                                            height:
                                                                screenHeight *
                                                                    0.08,
                                                            width: screenWidth *
                                                                0.2,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12))),
                                                          ),
                                                        ),
                                                      ),
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                              color: Colors
                                                                  .black26,
                                                              width: 1.0),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          _bookType(
                                                              "Other");
                                                        },
                                                        child: Container(
                                                          child: Center(
                                                              child: Text(
                                                            "Other",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black45,
                                                            ),
                                                          )),
                                                          height: screenHeight *
                                                              0.08,
                                                          width:
                                                              screenWidth * 0.2,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          12))),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                            ]),
                                      ),
                                      SizedBox(height: 20),
                                      Text(
                                        "Information",
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Divider(height: 2, color: Colors.black),
                                      SizedBox(height: 10),
                                      Container(
                                        height: screenHeight * 0.07,
                                        width: screenWidth * 0.9,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black45),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Outcome Type :"),
                                            SizedBox(
                                              width: 80,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white30,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                height: screenHeight * 0.08,
                                                width: screenWidth * 0.25,
                                                child: Center(
                                                    child: Text(_ouType)))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: screenHeight * 0.07,
                                        width: screenWidth * 0.9,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black45),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Curent Date Time :"),
                                            SizedBox(
                                              width: 100,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white30,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                height: screenHeight * 0.08,
                                                width: screenWidth * 0.25,
                                                child: Center(
                                                    child: Text(_curTime)))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: screenHeight * 0.07,
                                        width: screenWidth * 0.9,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black45),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Total Outcome :"),
                                            SizedBox(
                                              width: 107,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white30,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                height: screenHeight * 0.08,
                                                width: screenWidth * 0.25,
                                                child: Center(
                                                    child: TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: btoutcome,
                                                  decoration: InputDecoration(
                                                      prefixText: "RM ",
                                                      hintText: "--"),
                                                )))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        height: screenHeight * 0.07,
                                        width: screenWidth * 0.9,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black45),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15))),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Remark :"),
                                            SizedBox(
                                              width: 150,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white30,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                height: screenHeight * 0.08,
                                                width: screenWidth * 0.25,
                                                child: Center(
                                                    child: TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: bremark,
                                                  decoration: InputDecoration(
                                                    hintText: "       --",
                                                  ),
                                                )))
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          minWidth: screenWidth,
                                          height: 50,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text('Submit',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                          onPressed: _outsubmitdialog,
                                          color: Color(0xddd1b8f7)),
                                    ],
                                  ),
                                ))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
      }),
    );
  }

  void _bookType(String type) {
    setState(() {
      _ouType = type;
    });
  }

  void _outsubmitdialog() {
    submitwhat = "Outcome";
    type = _ouType.toString();
    price = double.tryParse(btoutcome.text);
    if (type == "none") {
      Fluttertoast.showToast(
          msg: "Select a Outcome Type",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (price == null || price <= 0) {
      Fluttertoast.showToast(
          msg: "Insert a valid price amount",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    sDialog(type, price);
  }

  void _insubmitdialog() {
    type = intype.text.toString();
    submitwhat = "Income";
    price = double.tryParse(btincome.text);

    if (type == null || type == "") {
      Fluttertoast.showToast(
          msg: "Insert a Income Type",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    if (price == null || price <= 0) {
      Fluttertoast.showToast(
          msg: "Insert a valid price amount",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    sDialog(type, price);
  }

  void sDialog(String type, double price) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Submit " + submitwhat + " ?"),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          actions: [
            TextButton(
              child: Text("Sure"),
              onPressed: () {
                _submit(type, price);
              },
            ),
            TextButton(
                child: Text("Wait"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  void _submit(String type, double price) {
      String remark = "";
      remark = bremark.text.toString();
      String _email = widget.user.email;
      String sprice = price.toString();
      http.post(
          Uri.parse(
              "https://hubbuddies.com/269971/countmee/php/addBookkeeping.php"),
          body: {
            "email": _email,
            "type": type,
            "datetime": _curTime,
            "price": sprice,
            "remark": remark,
            "bktype":submitwhat,
          }).then((response) {
        print(response.body);
        if (response.body == "success") {
          Fluttertoast.showToast(
              msg: "Add Success.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromRGBO(30, 191, 46, 50),
              textColor: Colors.white,
              fontSize: 16.0);
          FocusScope.of(context).unfocus();
          Navigator.pop(context);
          Navigator.pop(
              context, MaterialPageRoute(builder: (content) => MyBill()));
        } else {
          Fluttertoast.showToast(
              msg: "Add Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
    
  }
}
