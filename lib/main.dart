import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:plate_verify/display.dart';
import 'package:plate_verify/work.dart';
import 'package:plate_verify/login.dart';



void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => Cay(),
        'login': (context) => Login(),
        'cayman': (context) => Verify()
      },

    );
  }
}
