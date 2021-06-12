import 'package:carrots_lab_project/models/navigation_model.dart';
import 'package:carrots_lab_project/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
      ],
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
