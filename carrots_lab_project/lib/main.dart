import 'package:carrots_lab_project/screens/map_main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.green[900],
        fontFamily: "Montserrat",
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          bodyText1: TextStyle(fontSize: 14.0)
        ),
        primaryIconTheme: IconThemeData(
          color: Colors.orange
        ),
      ),
      home: MapMain()
    );
  }
}
