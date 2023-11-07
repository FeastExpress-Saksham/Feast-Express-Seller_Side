import 'package:flutter/material.dart';
import 'package:munchmate_admin/features/recentOrders/services/recent_orders_services.dart';
import 'package:munchmate_admin/providers/menu_provider.dart';
import 'package:provider/provider.dart';

import '../models/item.dart';
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

  void toggleDeliveryStatus(Order order, BuildContext context) async {
    List<Item> items = Provider.of<MenuProvider>(context, listen: false).items;
    await recentOrdersServices.toggleDeliveryStatus(order, items);
  }

  get lastOrders => _lastOrders;
}
