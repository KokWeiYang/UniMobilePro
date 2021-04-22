import 'package:flutter/material.dart';

import 'view/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Login App', home: SplashScreen());
    
  }
}
