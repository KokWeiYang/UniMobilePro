import 'package:countmee/model/user.dart';
import 'package:countmee/view/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'registrationscreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _forgotemailcontroller = TextEditingController();
  TextEditingController _forgotnewpasscontroller = TextEditingController();
  TextEditingController _forgotconpasscontroller = TextEditingController();
  SharedPreferences prefs;
  
  @override
  void initState() {
    loadPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: Colors.deepPurple[300],
        body: Center(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(15, 30, 15, 10),
                      child: Image.asset(
                        'assets/images/logo.png',
                        scale: 6,
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
                            '----------Login----------',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'Email', icon: Icon(Icons.email)),
                          ),
                          TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                labelText: 'Password', icon: Icon(Icons.lock)),
                            obscureText: true,
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Checkbox(
                                  value: _rememberMe,
                                  onChanged: (bool value) {
                                    _onChange(value);
                                  }),
                              Text("Remember Me")
                            ],
                          ),
                          MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              minWidth: 300,
                              height: 50,
                              child: Text('Login',
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              onPressed: _onLogin,
                              color: Colors.yellow),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        child: RichText(
                          text: TextSpan(
                            text: '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'F',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'orgot ',
                              ),
                              TextSpan(
                                text: 'P',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'assword?',
                              ),
                            ],
                          ),
                        ),
                        onTap: _forgotPassword,
                      ),
                      GestureDetector(
                        child: RichText(
                          text: TextSpan(
                            text: '',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'N',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'ot ',
                              ),
                              TextSpan(
                                text: 'R',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'egistered yet?',
                              ),
                            ],
                          ),
                        ),
                        onTap: _registerNewUser,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLogin() {
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();
    http.post(
        Uri.parse("https://hubbuddies.com/269971/countmee/php/login_user.php"),
        body: {"email": _email, "password": _password}).then((response) {
      print(response.body);
      if (response.body == "failed") {
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        List userdata = response.body.split(",");
        User user = User(
          email: _email,
          password: _password,
          name: userdata[1],
          address: userdata[2],
          datereg: userdata[3],
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (content) => MainScreen(user: user)));
      }
    });
  }

  void _registerNewUser() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => RegistrationScreen()));
  }

  void _forgotPassword() {
    showDialog(
        context: context,
        builder: (ctxDialog) =>
            SingleChildScrollView(child: forgetemailDialog()));
  }

  void _onChange(bool value) {
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();

    if (_email.isEmpty || _password.isEmpty) {
      Fluttertoast.showToast(
          msg: "Email/password is empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(191, 30, 46, 50),
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    }
    setState(() {
      _rememberMe = value;
      storePref(value, _email, _password);
    });
  }

  Future<void> storePref(bool value, String email, String password) async {
    prefs = await SharedPreferences.getInstance();
    if (value) {
      await prefs.setString("email", email);
      await prefs.setString("password", password);
      await prefs.setBool("rememberme", value);
      Fluttertoast.showToast(
          msg: "Preferences stored",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(30, 191, 46, 50),
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else {
      await prefs.setString("email", '');
      await prefs.setString("password", '');
      await prefs.setBool("rememberme", value);
      Fluttertoast.showToast(
          msg: "Preferences removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(30, 191, 46, 50),
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {
        _emailController.text = "";
        _passwordController.text = "";
        _rememberMe = false;
      });
      return;
    }
  }

  Future<void> loadPref() async {
    prefs = await SharedPreferences.getInstance();
    String _email = prefs.getString("email") ?? '';
    String _password = prefs.getString("password") ?? '';
    _rememberMe = prefs.getBool("rememberme") ?? false;

    setState(() {
      _emailController.text = _email;
      _passwordController.text = _password;
    });
  }

  void _resetPassword(String emailreset, String newpass, String conpass) {
    http.post(
        Uri.parse("https://hubbuddies.com/269971/countmee/php/reset_user.php"),
        body: {
          "email": emailreset,
          "newpass": newpass,
          "conpass": conpass
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Check your email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(30, 191, 46, 50),
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
      } else if (response.body == "failed1") {
        Fluttertoast.showToast(
            msg: "Failed, confirm password wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(191, 30, 46, 50),
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (response.body == "failed2") {
        Fluttertoast.showToast(
            msg: "Failed, not found this email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(191, 30, 46, 50),
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: "Failed, not verify account yet",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(191, 30, 46, 50),
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  forgetemailDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text("Forgot Password? \n Please enter your:"),
      content: new Container(
          height: 200,
          child: Column(
            children: [
              Row(
                children: [
                  Text('Email:'),
                ],
              ),
              TextField(
                controller: _forgotemailcontroller,
                decoration: InputDecoration(
                    labelText: 'Email', icon: Icon(Icons.email_outlined)),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          )),
      actions: [
        TextButton(
          child: Text("Next"),
          onPressed: () {
            showDialog(
                context: context,
                builder: (ctxDialog) =>
                    SingleChildScrollView(child: forgetpassDialog()));
          },
        ),
        TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  forgetpassDialog() {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: Text("Forgot Password? \n Please enter your:"),
        content: new Container(
          height: 200,
          child: Column(children: [
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: '',
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'NEW',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                        text: ' password:',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ],
            ),
            TextField(
              controller: _forgotnewpasscontroller,
              decoration: InputDecoration(
                  labelText: 'New Password', icon: Icon(Icons.lock_outlined)),
              obscureText: true,
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: '',
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'NEW',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                        text: ' password again:',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                ),
              ],
            ),
            TextField(
              controller: _forgotconpasscontroller,
              decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  icon: Icon(Icons.lock_outlined)),
              obscureText: true,
            )
          ]),
        ),
        actions: [
          TextButton(
            child: Text("Submit"),
            onPressed: () {
              Navigator.of(context).pop();
              _resetPassword(_forgotemailcontroller.text,
                  _forgotnewpasscontroller.text, _forgotconpasscontroller.text);
            },
          ),
          TextButton(
              child: Text("Back"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ]);
  }
}
