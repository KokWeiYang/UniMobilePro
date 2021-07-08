import 'package:countmee/model/delivery.dart';
import 'package:countmee/model/user.dart';
import 'package:countmee/view/mapscreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'mainscreen.dart';
import 'myprofile.dart';

void main() => runApp(EditProfiles());

class EditProfiles extends StatefulWidget {
  final User user;

  const EditProfiles({Key key, this.user}) : super(key: key);
  @override
  _EditProfilesState createState() => _EditProfilesState();
}

double screenHeight, screenWidth;

class _EditProfilesState extends State<EditProfiles> {
  TextEditingController _profnameController = new TextEditingController();
  TextEditingController _prolnameController = new TextEditingController();
  TextEditingController _prophoneController = new TextEditingController();
  TextEditingController _userlocctrl = new TextEditingController();
  String address = "";
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xbbb898f2),
      appBar: AppBar(
        backgroundColor: Color(0xddd3c1f0),
        title: Text('Edit Profile'),
        leading: GestureDetector(
          onTap: _backtomyproflie,
          child: Icon(
            Icons.arrow_back_outlined,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                onTap: updateProfile,
                child: Icon(
                  Icons.save,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.025,
                  ),
                  Container(
                    width: screenWidth * 0.950,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: screenHeight / 25),
                        Row(
                          children: [
                            Container(
                              width: (screenWidth * 0.950) / 2,
                              child: Text("E-mail : "),
                            ),
                            Container(
                              width: (screenWidth * 0.950) / 2,
                              child: Text(widget.user.email),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 22),
                        Row(
                          children: [
                            Container(
                              width: (screenWidth * 0.950) / 2,
                              child: Text("First name : "),
                            ),
                            Container(
                              color: Color(0xddd3c1f0),
                              width: (screenWidth * 0.950) / 2,
                              child: TextField(
                                controller: _profnameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 22),
                        Row(
                          children: [
                            Container(
                              width: (screenWidth * 0.950) / 2,
                              child: Text("Last name : "),
                            ),
                            Container(
                              color: Color(0xddd3c1f0),
                              width: (screenWidth * 0.950) / 2,
                              child: TextField(
                                controller: _prolnameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 22),
                        Row(
                          children: [
                            Container(
                              width: (screenWidth * 0.950) / 2,
                              child: Text("Phone number : "),
                            ),
                            Container(
                              color: Color(0xddd3c1f0),
                              width: (screenWidth * 0.950) / 2,
                              child: TextField(
                                controller: _prophoneController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "e.g. 0123456789",
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 22),
                        Row(
                          children: [
                            Container(
                              width: (screenWidth * 0.950) / 2,
                              child: Text("Business location : "),
                            ),
                            Container(
                              width: (screenWidth * 0.950) / 2,
                              color: Color(0xddd3c1f0),
                              child: TextField(
                                controller: _userlocctrl,
                                style: TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Search/Enter address'),
                                keyboardType: TextInputType.multiline,
                                minLines: 4,
                                maxLines: 4,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: screenWidth * 0.950 / 2),
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  Container(
                                    width: 150,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.deepPurple[300],
                                        ),
                                      ),
                                      onPressed: () async {
                                        Delivery _del =
                                            await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => MapPage(),
                                          ),
                                        );
                                        print(address);
                                        setState(
                                          () {
                                            _userlocctrl.text = _del.address;
                                          },
                                        );
                                      },
                                      child: Text("Map"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: screenHeight / 22),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _backtomyproflie() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text("EXIT"),
            content: Text("Are your sure? \nYou are not save yet."),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context,
                      MaterialPageRoute(builder: (context) => MyProfile()));
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

  void updateProfile() {
    String _fname = _profnameController.text.toString();
    String _lname = _prolnameController.text.toString();
    String _add1 = _userlocctrl.text.toString();
    String _phone = _prophoneController.text.toString();
    if (_fname.isEmpty || _lname.isEmpty) {
      Fluttertoast.showToast(
          msg: "Name is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_add1.isEmpty) {
      Fluttertoast.showToast(
          msg: "Address is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_phone.isEmpty) {
      Fluttertoast.showToast(
          msg: "Address is empty",
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
            title: Text("Submit"),
            content: Text("Are your sure? \nYou want submit now."),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _updateprofile(_fname, _lname, _add1, _phone);
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

  void _updateprofile(
      String _fname, String _lname, String _add1, String _phone) {
    String _email = widget.user.email;
    http.post(
        Uri.parse("https://hubbuddies.com/269971/countmee/php/update_user.php"),
        body: {
          "email": _email,
          "fname": _fname,
          "lname": _lname,
          "add1": _add1,
          "phone": _phone,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Update Success.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(30, 191, 46, 50),
            textColor: Colors.white,
            fontSize: 16.0);
        FocusScope.of(context).unfocus();
        Navigator.pop(context);
        Navigator.pop(
            context, MaterialPageRoute(builder: (content) => MainScreen()));
      } else {
        Fluttertoast.showToast(
            msg: "Update Failed",
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
