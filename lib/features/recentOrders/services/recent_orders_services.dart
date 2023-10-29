import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/order.dart';

class RecentOrdersServices {
  Future<List<Order>> getLastOrders() async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("orders");
    List<Order> lastOrders = [];
    databaseReference.onValue.listen((DatabaseEvent event) {
      lastOrders.clear();
      final data = event.snapshot.value;
      final res = jsonDecode(jsonEncode(data));
      if (res != null) {
        res.forEach((key, value) {
          lastOrders.add(Order.fromMap(value));
        });
      }
    });
    return lastOrders;
  }

  Future<void> changeAvailability(String orderID, bool isDelivered) async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("orders/$orderID");
    await databaseReference.update({"isDelivered": isDelivered}).onError(
        (error, stackTrace) => debugPrint(error.toString()));
  }
}
