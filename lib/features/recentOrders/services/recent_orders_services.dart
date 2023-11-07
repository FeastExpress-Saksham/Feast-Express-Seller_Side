import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../../../models/item.dart';
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

  Future<void> toggleDeliveryStatus(Order order, List<Item> items) async {
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
    if (!order.isDelivered) {
      for (int i = 0; i < order.items.length; i++) {
        DatabaseReference itemDatabaseReference =
            FirebaseDatabase.instance.ref("items/${order.items[i].id}");
        await itemDatabaseReference.update({
          "deliveredQuantity": items
                  .firstWhere((element) => element.id == order.items[i].id)
                  .deliveredQuantity +
              order.itemCounts[i],
          "pendingDelivery": items
                  .firstWhere((element) => element.id == order.items[i].id)
                  .pendingDelivery -
              order.itemCounts[i],
        }).onError((error, stackTrace) => debugPrint(error.toString()));
      }
    } else {
      for (int i = 0; i < order.items.length; i++) {
        DatabaseReference itemDatabaseReference =
            FirebaseDatabase.instance.ref("items/${order.items[i].id}");
        await itemDatabaseReference.update({
          "deliveredQuantity": items
                  .firstWhere((element) => element.id == order.items[i].id)
                  .deliveredQuantity -
              order.itemCounts[i],
          "pendingDelivery": items
                  .firstWhere((element) => element.id == order.items[i].id)
                  .pendingDelivery +
              order.itemCounts[i],
        }).onError((error, stackTrace) => debugPrint(error.toString()));
      }
    }
  }
}
