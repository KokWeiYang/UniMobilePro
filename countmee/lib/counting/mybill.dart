import 'dart:convert';
import 'package:countmee/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';
class MyBill extends StatefulWidget {
  final User user;

  const MyBill({Key key, this.user}) : super(key: key);
  @override
  _MyBillState createState() => _MyBillState();
}

class _MyBillState extends State<MyBill> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  String _titlecenter = "Loading...";
  double screenHeight, screenWidth;
  String _year = "${DateTime.now().year}";
  String _month = "${DateTime.now().month.toString().padLeft(2, '0')}";
  double _totalIncome = 0.00;
  double _totalOutcome = 0.00;
  double _totalBalance = 0.00;
  List _billlist;
  @override
  void initState() {
    super.initState();
    loadbill();
    loadbalance();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        top: true,
        left: false,
        bottom: true,
        right: false,
        child: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.deepPurple[300],
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: screenHeight * 0.155,
            flexibleSpace: const FlexibleSpaceBar(
                // title: Text('My'),
                background: Image(
              image: AssetImage('assets/images/bill.png'),
            )),
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Container(
                height: screenHeight * 0.72,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: screenHeight * 0.23,
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _year + '-' + _month,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Balance this month: "),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _totalBalance.toString(),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text("Income :"),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Outcome:"),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      _totalIncome.toString(),
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      _totalOutcome.toString(),
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                    SizedBox(height: 10),
                    Container(
                        height: screenHeight * 0.456,
                        child: Column(
                          children: [
                            _billlist == null
                                ? Flexible(
                                    child: Center(child: JumpingText(_titlecenter)))
                                : Flexible(
                                    child: Center(
                                      child: GridView.count(
                                        crossAxisCount: 1,
                                        childAspectRatio:
                                            (screenWidth / (screenHeight / 8)),
                                        children: List.generate(
                                          _billlist.length,
                                          (index) {
                                            return Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 1, 5, 1),
                                              child: Card(
                                                color: Colors.purple[100],
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            child: Text(
                                                              _billlist[index]
                                                                  [
                                                                  'billdate'],
                                                              style:
                                                                  TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            child: Text(
                                                              _billlist[index]
                                                                  ['billoi'],
                                                              style:
                                                                  TextStyle(
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 1, 8, 1),
                                                          child: Container(
                                                            child: Text(
                                                                _billlist[
                                                                        index]
                                                                    [
                                                                    'billtype']),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .fromLTRB(
                                                                  8, 1, 8, 1),
                                                          child: Container(
                                                            child: Text("RM" +
                                                                _billlist[
                                                                        index]
                                                                    [
                                                                    'billpric']),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // Container(
                                                    //   // height: screenWidth / 5,
                                                    //   child: Text(
                                                    //     'Sell on: ' +
                                                    //         _billlist[index]
                                                    //             [
                                                    //             'billrema'],
                                                    //     style:
                                                    //         TextStyle(
                                                    //       fontWeight:
                                                    //           FontWeight
                                                    //               .bold,
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ]));
  }

  void loadbill() {
    http.post(
        Uri.parse("https://hubbuddies.com/269971/countmee/php/load_bill.php"),
        body: {}).then((response) {
      if (response.body == "nodata") {
        _billlist = [];
        _titlecenter = "No product";
        return;
      } else {
        _titlecenter = "";
        var jsondata = json.decode(response.body);
        _billlist = jsondata["bill"];
        // print(_billlist);
      }
      setState(() {});
    });
  }

  void loadbalance() {
    loadOutcome();
    loadIncome();
    loadBalance();
  }

  void loadOutcome() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269971/countmee/php/load_balance.php"),
        body: {
          "type": "Outcome",
        }).then((response) {
      if (response.body == "nodata") {
        _totalOutcome = 0;
        return;
      } else {
        _totalOutcome = double.parse(response.body);
      }
      setState(() {});
    });
  }

  void loadIncome() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269971/countmee/php/load_balance.php"),
        body: {
          "type": "Income",
        }).then((response) {
      if (response.body == "nodata") {
        _totalIncome = 0;
        return;
      } else {
        _totalIncome = double.parse(response.body);
      }
      setState(() {});
    });
  }

  void loadBalance() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269971/countmee/php/load_balance.php"),
        body: {
          "type": "Balance",
        }).then((response) {
      if (response.body == "nodata") {
        _totalBalance = 0;
        return;
      } else {
        _totalBalance = double.parse(response.body);
      }
      setState(() {});
    });
  }
}
