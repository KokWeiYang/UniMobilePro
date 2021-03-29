import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController numaTextEditingController = new TextEditingController();
  TextEditingController numbTextEditingController = new TextEditingController();
  double result = 0.0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            width: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("First Number"),
                    Container(
                      width: 200,
                      child: TextField(
                        controller: numaTextEditingController,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Seond Number"),
                    Container(
                      width: 200,
                      child: TextField(
                        controller: numbTextEditingController,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text("+"),
                      onPressed: () => calculateMe(1),
                    ),
                    RaisedButton(
                      child: Text("-"),
                      onPressed: () => calculateMe(2),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text("*"),
                      onPressed: () => calculateMe(3),
                    ),
                    RaisedButton(
                      child: Text("/"),
                      onPressed: () => calculateMe(4),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Result = " + result.toStringAsFixed(2))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateMe(int op) {
    setState(() {
      double numa = double.parse(numaTextEditingController.text);
      double numb = double.parse(numbTextEditingController.text);
      switch (op) {
        case 1:
          result = numa + numb;
          break;

        case 2:
          result = numa - numb;
          break;

        case 3:
          result = numa * numb;
          break;

        case 4:
          result = numa / numb;
          break;

          break;
        default:
      }
      print(result);
    });
  }
}
