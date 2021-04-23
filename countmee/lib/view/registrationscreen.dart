import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'loginscreen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordControllera = new TextEditingController();
  TextEditingController _passwordControllerb = new TextEditingController();
  double screenHeight, screenWidth;
  bool _autoValidate = false;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: Center(
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(5, 50, 0, 10),
                          child: RichText(
                            text: TextSpan(
                              text: 'W',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                  color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'elcome to use',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.black)),
                              ],
                            ),
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(1, 20, 5, 10),
                          child: Image.asset(
                            'assets/images/logo.png',
                            scale: 8,
                          )),
                    ],
                  ),
                  SizedBox(height: 25),
                  Card(
                    color: Colors.white54,
                    margin: EdgeInsets.fromLTRB(30, 5, 30, 15),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Column(
                        children: [
                          Text(
                            'Registration',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Form(
                            autovalidate: _autoValidate,
                            child: TextFormField(
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                  labelText: 'Name', icon: Icon(Icons.person)),
                              validator: validateName,
                            ),
                          ),
                          Form(
                            autovalidate: _autoValidate,
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'Email', icon: Icon(Icons.email)),
                              validator: (value) =>
                                  EmailValidator.validate(value)
                                      ? null
                                      : "Please enter a valid email",
                            ),
                          ),
                          Form(
                            autovalidate: _autoValidate,
                            child: TextFormField(
                              controller: _passwordControllera,
                              decoration: InputDecoration(
                                  labelText: 'Password',
                                  icon: Icon(Icons.lock)),
                              obscureText: true,
                              validator: validatePassword,
                            ),
                          ),
                          Form(
                            autovalidate: _autoValidate,
                            child: TextFormField(
                              controller: _passwordControllerb,
                              decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  icon: Icon(Icons.lock)),
                              obscureText: true,
                              validator: validatePasswordMatching,
                            ),
                          ),
                          SizedBox(height: 10),
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              minWidth: screenWidth,
                              height: 50,
                              child: Text('Register',
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              onPressed: _onRegister,
                              color: Colors.yellow),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 100),
                      GestureDetector(
                        child: Text("Already registered?",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline)),
                        onTap: _alreadyRegister,
                      ),
                    ],
                  ),
                  SizedBox(height: 10)
                ],
              ),
            )),
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

  String validatePassword(String value) {
    if (value.length == 0) {
      return "Password is Required";
    } else if (value.length < 6) {
      return "Password Should be more than 6.";
    }
    return null;
  }

  String validatePasswordMatching(String value) {
    var password = _passwordControllera.text;
    if (value.length == 0) {
      return "Password is Required";
    } else if (value != password) {
      return 'Password is not matching';
    }
    return null;
  }

  void _alreadyRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => LoginScreen()));
  }

  void _onRegister() {
    String _name = _nameController.text.toString();
    String _email = _emailController.text.toString();
    String _passworda = _passwordControllera.text.toString();
    String _passwordb = _passwordControllerb.text.toString();
    setState(() {
      _autoValidate = true;
    });
    if (_name.isEmpty) {
      Fluttertoast.showToast(
          msg: "Name is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_email.isEmpty || _passworda.isEmpty || _passwordb.isEmpty) {
      Fluttertoast.showToast(
          msg: "Email/password is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (_passworda.length < 6) {
      return;
    } else if (_passworda != _passwordb) {
      return;
    } else if (!EmailValidator.validate(_email, true)) {
      Fluttertoast.showToast(
          msg: "Email is wrong",
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
            title: Text("Register new user"),
            content: Text("Are your sure?"),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _registerUser(_name, _email, _passworda);
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

  void _registerUser(String name, String email, String password) {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269971/countmee/php/register_user.php"),
        body: {
          "name": name,
          "email": email,
          "password": password
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg:
                "Registration Success. Please check your email for verification link",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(30, 191, 46, 50),
            textColor: Colors.white,
            fontSize: 16.0);
        FocusScope.of(context).unfocus();
        _nameController.clear();
        _emailController.clear();
        _passwordControllera.clear();
        _passwordControllerb.clear();
        Navigator.push(
            context, MaterialPageRoute(builder: (content) => LoginScreen()));
      } else {
        Fluttertoast.showToast(
            msg: "Registration Failed",
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
