import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int _selectedScreenIndex = 2;

  void updateSelectedScreenIndex(int newIndex) {
    _selectedScreenIndex = newIndex;
    notifyListeners();
  }

  get selectedScreenIndex => _selectedScreenIndex;
}
