import 'package:carrots_lab_project/models/navigation_model.dart';
import 'package:carrots_lab_project/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      ChangeNotifierProvider<NavigationModel>(
      create: (context) => NavigationModel(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() {
    return new _MyAppState();
  }

}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationModel>(context);
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
      home: Home()
    );
  }
}
