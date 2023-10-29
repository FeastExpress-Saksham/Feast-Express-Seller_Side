import 'package:flutter/material.dart';
import 'package:munchmate_admin/features/recentOrders/services/recent_orders_services.dart';

import '../models/order.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> _lastOrders = [];

  RecentOrdersServices recentOrdersServices = RecentOrdersServices();

  void getLastOrders() async {
    List<Order> realtimeOrders = await recentOrdersServices.getLastOrders();
    if (_lastOrders.isEmpty) {
      _lastOrders = realtimeOrders;
      notifyListeners();
    }
  }

  void toggleAvailability(int index) async {
    await recentOrdersServices.changeAvailability(
        _lastOrders[index].id, !_lastOrders[index].isDelivered);
    notifyListeners();
  }

  get lastOrders => _lastOrders;
}
