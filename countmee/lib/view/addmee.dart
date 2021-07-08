import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

import 'mainscreen.dart';

void main() => runApp(AddMee());

class AddMee extends StatefulWidget {
  @override
  _AddMeeState createState() => _AddMeeState();
}

class _AddMeeState extends State<AddMee> {
  TextEditingController _prnameController = new TextEditingController();
  TextEditingController _prprice1Controller = new TextEditingController();
  TextEditingController _prprice2Controller = new TextEditingController();
  TextEditingController _prmateController = new TextEditingController();
  double screenHeight, screenWidth;
  String pathAsset = 'assets/images/addimage.png';
  ProgressDialog pr;
  File _image;
  bool _autoValidate = false;
  String _prsd = "--";
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'Mee',
      home: Scaffold(
        backgroundColor: Color(0xbbb898f2),
        appBar: AppBar(
          backgroundColor: Color(0xddd3c1f0),
          title: Text('New Mee'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined, color: Colors.white),
            onPressed: () {
              Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => MainScreen()));
            },
          ),
        ),
        body: Center(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: _addingimage,
                        child: Container(
                            height: screenHeight / 2.5,
                            width: screenWidth / 1,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: _image == null
                                    ? AssetImage(pathAsset)
                                    : FileImage(_image),
                                fit: BoxFit.scaleDown,
                              ),
                            )),
                      )),
                  Card(
                    color: Colors.white54,
                    margin: EdgeInsets.fromLTRB(30, 5, 30, 15),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Column(
                        children: [
                          Text(
                            'Add a new mee, key-in the information below.',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 10),
                          Form(
                            // ignore: deprecated_member_use
                            autovalidate: _autoValidate,
                            child: TextFormField(
                              controller: _prnameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  icon: Icon(Icons.edit_outlined)),
                              validator: validateName,
                            ),
                          ),
                          Form(
                            // ignore: deprecated_member_use
                            autovalidate: _autoValidate,
                            child: TextFormField(
                              controller: _prprice1Controller,
                              decoration: InputDecoration(
                                  labelText: 'Price for small',
                                  icon: Icon(Icons.attach_money)),
                              validator: validatePrice1,
                            ),
                          ),
                          Form(
                            // ignore: deprecated_member_use
                            autovalidate: _autoValidate,
                            child: TextFormField(
                              controller: _prprice2Controller,
                              decoration: InputDecoration(
                                  labelText: 'Price for large',
                                  icon: Icon(Icons.attach_money)),
                              validator: validatePrice2,
                            ),
                          ),
                          SizedBox(height: 15),
                          Form(
                            // ignore: deprecated_member_use
                            autovalidate: _autoValidate,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.date_range,
                                  color: Colors.black54,
                                  size: 24.0,
                                ),
                                SizedBox(
                                  width: screenWidth / 20,
                                ),
                                Text("Sell day",
                                    style: TextStyle(color: Colors.black54)),
                                SizedBox(
                                  width: screenWidth / 6,
                                ),
                                Container(
                                    color: Colors.white54,
                                    padding: EdgeInsets.all(1.0),
                                    child: DropdownButton(
                                        value: _prsd,
                                        items: [
                                          DropdownMenuItem(
                                            child: Text(" -- "),
                                            value: "--",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Sunday"),
                                            value: "Sunday",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Monday"),
                                            value: "Monday",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Tuesday"),
                                            value: "Tuesday",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Wednesday"),
                                            value: "Wednesday",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Thursday"),
                                            value: "Thursday",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Friday"),
                                            value: "Friday",
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Saturday"),
                                            value: "Saturday",
                                          ),
                                        ],
                                        // ignore: unnecessary_statements
                                        onChanged: (value) {
                                          setState(() {
                                            _prsd = value;
                                          });
                                        }))
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Form(
                            // ignore: deprecated_member_use
                            autovalidate: _autoValidate,
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: _prmateController,
                              decoration: InputDecoration(
                                  labelText: 'Ingredients',
                                  icon: Icon(Icons.auto_awesome)),
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
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
                      onPressed: _submitdialog,
                      color: Color(0xddd1b8f7)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      _prnameController.clear();
      return "Name must be a-z and A-Z";
    } else if (value.length > 30) {
      _prnameController.clear();
      return "The length can't more than 30 values.";
    }
    return null;
  }

  String validatePrice1(String value) {
    if (value.length == 0) {
      return "Price is Required";
    } else if (value.length > 7) {
      _prprice1Controller.clear();
      return "Price can't more than 6 values.";
    }
    return null;
  }

  String validatePrice2(String value) {
    if (value.length == 0) {
      return "Price is Required";
    } else if (value.length > 7) {
      _prprice2Controller.clear();
      return "Price can't more than 6 values.";
    }
    return null;
  }

  String validatesellday(String value) {
    if (value == "--") {
      return "Sell Day is Required";
    }
    return null;
  }

  void _addingimage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: new Container(
            //color: Colors.white,
            height: screenHeight / 4,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Upload image from:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                        child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      minWidth: 100,
                      height: 100,
                      child: Column(
                        children: [
                          Icon(Icons.add_a_photo_outlined),
                          SizedBox(
                            width: 15,
                          ),
                          Text('Camera',
                              style: TextStyle(
                                color: Colors.black,
                              )),
                        ],
                      ),
                      color: Theme.of(context).accentColor,
                      elevation: 10,
                      onPressed: () =>
                          {Navigator.pop(context), _chooseCamera()},
                    )),
                    SizedBox(width: 10),
                    Flexible(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 100,
                        height: 100,
                        child: Column(
                          children: [
                            Icon(Icons.image_outlined),
                            SizedBox(
                              width: 15,
                            ),
                            Text('Gallery',
                                style: TextStyle(
                                  color: Colors.black,
                                )),
                          ],
                        ),
                        color: Theme.of(context).accentColor,
                        elevation: 10,
                        onPressed: () =>
                            {Navigator.pop(context), _chooseGallery()},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future _chooseCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    } else {
      print('No image selected.');
    }
  }

  _chooseGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    } else {
      print('No image selected.');
    }
  }

  _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop your image',
            toolbarColor: Colors.red,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _submitdialog() {
    String prsname = _prnameController.text.toString();
    String prsprice1 = _prprice1Controller.text.toString();
    String prsprice2 = _prprice2Controller.text.toString();
    String prsqty = _prsd.toString();
    setState(() {
      _autoValidate = true;
    });
    if (_image == null) {
      Fluttertoast.showToast(
          msg: "Image is Empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (prsname.isEmpty ||
        prsprice1.isEmpty ||
        prsprice2.isEmpty ||
        prsqty.isEmpty) {
      Fluttertoast.showToast(
          msg: "Something Wrong!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_prsd == "--") {
      Fluttertoast.showToast(
          msg: "Sell Day is Required!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Text("Upload New Product?"),
          content: Text("Are your sure?"),
          actions: [
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                _submitnewproduct();
              },
            ),
            TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  Future<void> _submitnewproduct() async {
    pr = ProgressDialog(context);
    pr.style(
      message: 'Posting...',
      borderRadius: 5.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInCubic,
    );
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    await pr.show();
    String base64Image = base64Encode(_image.readAsBytesSync());
    String prsname = _prnameController.text.toString();
    String prsprice1 = _prprice1Controller.text.toString();
    String prsprice2 = _prprice2Controller.text.toString();
    String prqsd = _prsd.toString();  
    String prmater = _prmateController.text.toString();
    print(prsname);
    print(prsprice1);
    print(prsprice2);
    print(prqsd);
    http.post(
        Uri.parse("https://hubbuddies.com/269971/countmee/php/newmee.php"),
        body: {
          "prname": prsname,
          "prprice1": prsprice1,
          "prprice2": prsprice2,
          "prqsd": prqsd,
          "prmater": prmater,
          "encoded_string": base64Image,
        }).then(
      (response) {
        pr.hide().then((isHidden) {
          print(isHidden);
        });
        print(response.body);
        if (response.body == "success") {
          Fluttertoast.showToast(
              msg: "Upload Success!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color.fromRGBO(30, 191, 46, 50),
              textColor: Colors.white,
              fontSize: 16.0);
          setState(() {
            _image = null;
            _prnameController.text = "";
            _prprice1Controller.text = "";
            _prprice2Controller.text = "";
            _prsd = "--";
          });
          Navigator.pop(
              context, MaterialPageRoute(builder: (content) => MainScreen()));
              setState(() {});
              
        } else if (response.body == "failed1") {
          Fluttertoast.showToast(
              msg: "Price for small can't more than Price for large!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Upload Failed!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
    );
  }
}
