import 'package:countmee/model/user.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class Chart extends StatefulWidget {
  final User user;
  const Chart({Key key, this.user}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  double _totalIncome = 0.00;
  double _totalOutcome = 0.00;

  Map<String, double> dataMap = {
    "Outcome(RM)": 0,
    "Income(RM)": 0,
  };
String _year = "${DateTime.now().year}";
  String _month = "${DateTime.now().month.toString().padLeft(2, '0')}";
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  ProgressDialog pr;
  double screenHeight, screenWidth;

  void initState() {
    super.initState();
    loadOutcome();
    loadIncome();
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
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.deepPurple[300],
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: screenHeight * 0.155,
            flexibleSpace: const FlexibleSpaceBar(
                // title: Text('My'),
                background: Image(
              image: AssetImage('assets/images/Chart.png'),
            )),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(height: screenHeight * 0.36,
                  child: Card(
                    color: Color(0x00000000),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Bookkeeping in "+_year + '-' + _month,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height: screenHeight * 0.2,
                              width: screenWidth,
                              child: PieChart(
                                dataMap: dataMap,
                                animationDuration: Duration(milliseconds: 800),
                                chartLegendSpacing: 32,
                                chartRadius:
                                    MediaQuery.of(context).size.width / 3.2,
                                // colorList: colorList,
                                initialAngleInDegree: 0,
                                chartType: ChartType.ring,
                                ringStrokeWidth: 32,
                                chartValuesOptions: ChartValuesOptions(
                                  showChartValueBackground: true,
                                  showChartValues: true,
                                  showChartValuesInPercentage: false,
                                  showChartValuesOutside: false,
                                  decimalPlaces: 1,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void loadOutcome() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269971/countmee/php/load_balance.php"),
        body: {
          "type": "Outcome",
        }).then((response) {
      // print(response.body);
      if (response.body == "nodata") {
        _totalOutcome = 0;
        return;
      } else {
        _totalOutcome = double.parse(response.body);
      }
      setState(() {
        dataMap.update("Outcome(RM)", (v) {
          print(v);
          return _totalOutcome;
        });
      });
    });
  }

  void loadIncome() {
    http.post(
        Uri.parse(
            "https://hubbuddies.com/269971/countmee/php/load_balance.php"),
        body: {
          "type": "Income",
        }).then((response) {
      // print(response.body);
      if (response.body == "nodata") {
        _totalIncome = 0;
        return;
      } else {
        _totalIncome = double.parse(response.body);
      }
      setState(() {
        dataMap.update("Income(RM)", (v) {
          print(v);
          return _totalIncome;
        });
      });
    });
  }
}
