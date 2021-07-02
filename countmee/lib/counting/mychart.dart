import 'dart:convert';
import 'dart:io';
import 'package:countmee/model/user.dart';
import 'package:countmee/view/countingscreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class Chart extends StatefulWidget {
  final User user;

  const Chart({Key key, this.user}) : super(key: key);
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  ProgressDialog pr;
  double screenHeight, screenWidth;
  File _image;
  final _focus = FocusNode();

  TextEditingController _descCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Container(
              // margin: EdgeInsets.fromLTRB(15, 30, 15, 10),
              child: Image.asset(
                'assets/images/Chart.png',
                scale: 2,
              )),
          
        ],
      ),
    );
  }

}
