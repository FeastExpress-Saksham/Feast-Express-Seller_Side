import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

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
        res.forEach((key, value) {
          if (!lastOrders.contains(Order.fromMap(value))) {
            lastOrders.add(Order.fromMap(value));
          }
        });
      }
    });
    return lastOrders;
  }
}
