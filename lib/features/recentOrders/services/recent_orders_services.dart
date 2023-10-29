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
      final data = event.snapshot.value;
      final res = jsonDecode(jsonEncode(data));
      if (res != null) {
        lastOrders.clear();
        res.forEach((key, value) {
          lastOrders.add(Order.fromMap(value));
        });
      }
    });
    return lastOrders;
  }

  Future<void> toggleDeliveryStatus(Order order) async {
    DatabaseReference ordersDatabaseReference =
        FirebaseDatabase.instance.ref("orders/${order.id}");
    DatabaseReference usersDatabaseReference = FirebaseDatabase.instance
        .ref("users/${order.orderedBy}/orders/${order.id}");
    await ordersDatabaseReference
        .update({"isDelivered": !order.isDelivered}).onError(
            (error, stackTrace) => debugPrint(error.toString()));
    await usersDatabaseReference
        .update({"isDelivered": !order.isDelivered}).onError(
            (error, stackTrace) => debugPrint(error.toString()));
  }
}
