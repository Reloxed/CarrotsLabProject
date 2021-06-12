import 'package:flutter/material.dart';

class NavigationModel extends ChangeNotifier {
  int selectedIndex = 0;

  void changePage(int i){
    selectedIndex = i;
    notifyListeners();
  }
}