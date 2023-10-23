import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  String _selectedScreenTileTitle = "Dashboard";

  void updateSelectedScreenIndex(String newTileTitle) {
    _selectedScreenTileTitle = newTileTitle;
    notifyListeners();
  }

  get selectedScreenTileTitle => _selectedScreenTileTitle;
}
