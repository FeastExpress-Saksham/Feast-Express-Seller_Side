import 'package:flutter/material.dart';
import 'package:munchmate_admin/features/home/services/home_services.dart';

import '../models/user.dart';

class HomeProvider extends ChangeNotifier {
  int _selectedScreenIndex = 2;
  List<LocalUser> _localUsers = [];
  HomeServices homeServices = HomeServices();

  void updateSelectedScreenIndex(int newIndex) {
    _selectedScreenIndex = newIndex;
    notifyListeners();
  }

  void getLocalUsers() async {
    _localUsers = await homeServices.getLocalUsers();
    notifyListeners();
  }

  get selectedScreenIndex => _selectedScreenIndex;
  get localUsers => _localUsers;
}
