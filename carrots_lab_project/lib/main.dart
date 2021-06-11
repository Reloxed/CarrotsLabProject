import 'package:carrots_lab_project/screens/insert_place.dart';
import 'package:carrots_lab_project/screens/map_main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static int selectedIndex = 0;
  @override
  _MyAppState createState() {
    return new _MyAppState();
  }

}

class _MyAppState extends State<MyApp> {
  static List<Widget> _widgetOptions = [
    MapMain(),
    InsertPlace()
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.green[900],
        fontFamily: "Montserrat",
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 10.0),
          bodyText1: TextStyle(fontSize: 14.0)
        ),
        primaryIconTheme: IconThemeData(
          color: Colors.orange
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Carrots Lab Map", style: Theme.of(context).textTheme.headline4),
        ),
        body: _widgetOptions.elementAt(MyApp.selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: MyApp.selectedIndex,
          items: [BottomNavigationBarItem(icon: Icon(Icons.map), label: "Mapa"),
            BottomNavigationBarItem(icon: Icon(Icons.push_pin), label: "Lugares")],
          onTap: (index) => {
            setState(() {
              MyApp.selectedIndex = index;
            })
          }
        ),
      )
    );
  }
}
