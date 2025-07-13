import 'package:cloud_firestore/cloud_firestore.dart';

class InventoryItem {
  String? id;
  String name;
  int quantity;
  String userId;

  InventoryItem({
    this.id,
    required this.name,
    required this.quantity,
    required this.userId,
  });

  factory InventoryItem.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InventoryItem(
      id: doc.id,
      name: data['name'] ?? '',
      quantity: data['quantity'] ?? 0,
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'quantity': quantity,
      'userId': userId,
    };
  }
}
