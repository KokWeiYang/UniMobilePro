import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'main.dart';

void main() => runApp(NewProduct());

class NewProduct extends StatefulWidget {
  @override
  _NewProductState createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  TextEditingController _prnameController = new TextEditingController();
  TextEditingController _prtypeController = new TextEditingController();
  TextEditingController _prpriceController = new TextEditingController();
  TextEditingController _prqtyController = new TextEditingController();
  double screenHeight, screenWidth;
  String pathAsset = 'assets/image/Empty.png';
  ProgressDialog pr;
  File _image;
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'MY SHOP',
      home: Scaffold(
        appBar: AppBar(
          title: Text('New Product'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  color: Colors.white54,
                  margin: EdgeInsets.fromLTRB(30, 5, 30, 15),
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Column(
                      children: [
                        Text(
                          'Add a new product, key-in the information below.',
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
                                labelText: 'Product Name',
                                icon: Icon(Icons.edit_outlined)),
                            validator: validateName,
                          ),
                        ),
                        Form(
                          // ignore: deprecated_member_use
                          autovalidate: _autoValidate,
                          child: TextFormField(
                            controller: _prtypeController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'Product Type',
                                icon: Icon(Icons.bookmarks_sharp)),
                            validator: validateType,
                          ),
                        ),
                        Form(
                          // ignore: deprecated_member_use
                          autovalidate: _autoValidate,
                          child: TextFormField(
                            controller: _prpriceController,
                            decoration: InputDecoration(
                                labelText: 'Product Price',
                                icon: Icon(Icons.attach_money)),
                            validator: validatePrice,
                          ),
                        ),
                        Form(
                          // ignore: deprecated_member_use
                          autovalidate: _autoValidate,
                          child: TextFormField(
                            controller: _prqtyController,
                            decoration: InputDecoration(
                                labelText: 'Product Quantity',
                                icon: Icon(Icons.storage)),
                            validator: validateQuantity,
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
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
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            minWidth: screenWidth,
                            height: 50,
                            child: Row(
                              children: [
                                Icon(Icons.add_a_photo),
                                SizedBox(
                                  width: 15,
                                ),
                                Text('Upload image',
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                              ],
                            ),
                            onPressed: _addingimage,
                            color: Colors.blue[50]),
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
                    color: Colors.blue[200]),
              ],
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
      return "Name must be a-z and A-Z";
    }
    return null;
  }

  String validateType(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(patttern);
    if (value.length == 0) {
      return "Type is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Type must be a-z and A-Z";
    }
    return null;
  }

  String validatePrice(String value) {
    if (value.length == 0) {
      return "Price is Required";
    } else if (value.length > 6) {
      return "Price can't more than 4 values.";
    }
    return null;
  }

  String validateQuantity(String value) {
    if (value.length == 0) {
      return "Quantity is Required";
    } else if (value.length > 6) {
      return "Quantity can't more than 6 values.";
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
                        //color: Color.fromRGBO(101, 255, 218, 50),
                        color: Theme.of(context).accentColor,
                        elevation: 10,
                        onPressed: () =>
                            {Navigator.pop(context), _chooseGallery()},
                      )),
                    ],
                  ),
                ],
              ),
            ));
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
    } else {
      print('No image selected.');
    }

    _cropImage();
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
    } else {
      print('No image selected.');
    }

    _cropImage();
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
    setState(() {
      _autoValidate = true;
    });
    if(_image == null){
      Fluttertoast.showToast(
            msg: "Image is Empty!",
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
        });
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
    String prstype = _prtypeController.text.toString();
    String prsprice = _prpriceController.text.toString();
    String prsqty = _prqtyController.text.toString();
    http.post(
        Uri.parse("https://hubbuddies.com/269971/myshop/php/add_image.php"),
        body: {
          "prname": prsname,
          "prtype": prstype,
          "prprice": prsprice,
          "prqty": prsqty,
          "encoded_string": base64Image,
        }).then((response) {
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
          _prtypeController.text = "";
          _prpriceController.text = "";
          _prqtyController.text = "";
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (content) => MyShop()));
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
    });
  }
}
