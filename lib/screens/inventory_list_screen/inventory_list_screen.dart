import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/firestore/inventory_firestore_service.dart';
import '../../models/inventory_item.dart';
import '../add_inventory_screen/add_inventory_screen.dart';

class InventoryListScreen extends StatelessWidget {
  final InventoryFirestoreService _service = InventoryFirestoreService();

  InventoryListScreen({super.key});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _navigateToAddItem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddInventoryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text("User not logged in"));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          )
        ],
      ),
      body: StreamBuilder<List<InventoryItem>>(
        stream: _service.getInventoryItems(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return const Center(child: Text('No inventory items yet.'));
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('Qty: ${item.quantity}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _service.deleteInventoryItem(item.id!),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddItem(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
