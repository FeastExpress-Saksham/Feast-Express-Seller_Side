import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:munchmate_admin/features/menu/services/menu_services.dart';

import '../models/item.dart';

class MenuProvider extends ChangeNotifier {
  List<Item> _items = [];
  String _imageUrl = '';
  MenuServices menuServices = MenuServices();

  void uploadImage(Uint8List imageData, String itemID) async {
    _imageUrl = await menuServices.uploadImage(imageData, itemID);
    notifyListeners();
  }

  void addItem(Item item) async {
    await menuServices.addItem(item);
    notifyListeners();
  }

  void updateItem(Item item) async {
    await menuServices.updateItem(item);
    notifyListeners();
  }

  void getItems() async {
    List<Item> realTimeItems = await menuServices.getItems();
    if (_items.isEmpty) {
      _items = realTimeItems;
    }
    notifyListeners();
  }

  void toggleAvailability(int index) async {
    await menuServices.changeAvailability(
        _items[index].id, !_items[index].isAvailable);
    notifyListeners();
  }

  get items => _items;
  get imageUrl => _imageUrl;
}
