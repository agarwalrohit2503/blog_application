import 'package:blog_application/models/store_item.dart';
import 'package:flutter/material.dart';

class CartNotifier extends ChangeNotifier {
  List<StoreItem> _cartItems = const [];

  List<StoreItem> get storeItems => _cartItems;
}
