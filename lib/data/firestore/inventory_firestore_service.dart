import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/inventory_item.dart';

class InventoryFirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = 'inventories';

  Stream<List<InventoryItem>> getInventoryItems(String userId) {
    return _firestore
        .collection(collectionPath)
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => InventoryItem.fromFirestore(doc))
            .toList());
  }

  Future<void> addInventoryItem(InventoryItem item) async {
    await _firestore.collection(collectionPath).add(item.toFirestore());
  }

  Future<void> deleteInventoryItem(String id) async {
    await _firestore.collection(collectionPath).doc(id).delete();
  }

  Future<InventoryItem?> getInventoryItemById(String id) async {
    final doc = await _firestore.collection(collectionPath).doc(id).get();
    if (doc.exists) {
      return InventoryItem.fromFirestore(doc);
    } else {
      return null;
    }
  }
}
