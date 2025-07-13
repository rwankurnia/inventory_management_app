import 'package:flutter/material.dart';
import '../../models/inventory_item.dart';

class InventoryDetailScreen extends StatelessWidget {
  final InventoryItem item;

  const InventoryDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Item Name:', style: Theme.of(context).textTheme.titleMedium),
            Text(item.name, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text('Quantity:', style: Theme.of(context).textTheme.titleMedium),
            Text(item.quantity.toString(), style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            Text('User ID:', style: Theme.of(context).textTheme.titleMedium),
            Text(item.userId, style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}