import 'package:cloud_firestore/cloud_firestore.dart';

class StoreItem {
  final String id;
  final String name;
  final String imageURL;
  final num price;

  StoreItem({
    required this.id,
    required this.name,
    required this.imageURL,
    required this.price,
  });
  factory StoreItem.fromJson(DocumentSnapshot product) {
    final map = product.data() as Map;

    return StoreItem(
      id: product.id,
      name: map['name'] ?? "",
      imageURL: map['imageURL'] ?? "",
      price: map['price'] ?? "",
    );
  }
}
