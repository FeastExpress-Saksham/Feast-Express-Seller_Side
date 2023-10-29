import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../models/item.dart';

class MenuServices {
  Future<void> addItem(Item item) async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("items/${item.id}");
    databaseReference.set(item.toMap());
  }

  Future<void> updateItem(Item item) async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("items/${item.id}");
    databaseReference.update(item.toMap());
  }

  Future<List<Item>> getItems() async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("items");
    final List<Item> items = [];
    databaseReference.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      final res = jsonDecode(jsonEncode(data));
      int i = 1;
      items.clear();
      while (true && data != null) {
        if (res["ITEM$i"] == null) {
          break;
        }
        items.add(Item.fromMap(res["ITEM$i"]));
        i++;
      }
    });
    return items;
  }

  Future<String> uploadImage(Uint8List imageData, String itemID) async {
    final ref = FirebaseStorage.instance.ref("items").child(itemID);
    UploadTask uploadTask = ref.putData(imageData);
    final snapshot = await uploadTask.whenComplete(() {});
    final imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> changeAvailability(String itemID, bool isAvailable) async {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref("items/$itemID");
    await databaseReference.update({"isAvailable": isAvailable});
  }
}
