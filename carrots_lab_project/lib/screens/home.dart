import 'package:carrots_lab_project/models/navigation_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'insert_place.dart';
import 'map_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  static List<Widget> _widgetOptions = [
    MapMain(),
    InsertPlace()
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NavigationModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrots Lab Map", style: Theme.of(context).textTheme.headline4),
      ),
      body: _widgetOptions.elementAt(provider.selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          currentIndex: provider.selectedIndex,
          items: [BottomNavigationBarItem(icon: Icon(Icons.map), label: AppLocalizations.of(context)!.map),
            BottomNavigationBarItem(icon: Icon(Icons.push_pin), label: AppLocalizations.of(context)!.places)],
          onTap: (index) {
            provider.changePage(index);
          }
      ),
    );
  }

}