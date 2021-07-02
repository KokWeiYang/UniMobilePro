
import 'package:countmee/model/user.dart';
import 'package:flutter/material.dart';

class MyBill extends StatefulWidget {
  final User user;

  const MyBill({Key key, this.user}) : super(key: key);
  @override
  _MyBillState createState() => _MyBillState();
}

class _MyBillState extends State<MyBill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              // margin: EdgeInsets.fromLTRB(15, 30, 15, 10),
              child: Image.asset(
                'assets/images/bill.png',
                scale: 2,
              )),
        ],
      ),
    );
  }
}
