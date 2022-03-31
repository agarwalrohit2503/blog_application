import 'package:blog_application/models/store_item.dart';
import 'package:flutter/material.dart';

class CartNotifier extends ChangeNotifier {
  final List<StoreItem> _cartItems = [];

  List<StoreItem> get storeItems => _cartItems;

  void remove(StoreItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void add(StoreItem item) {
    _cartItems.add(item);
    notifyListeners();
  }

  bool isInCart(StoreItem item) {
    return _cartItems.contains(item);
  }

  num get totalPrice {
    return _cartItems.fold(
        0, (previousValue, element) => previousValue + element.price);
  }
}
