import 'package:exer6/model/item.dart';
import 'package:exer6/provider/shopping_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCatalog extends StatefulWidget {
  const MyCatalog({super.key});

  @override
  State<MyCatalog> createState() => _MyCatalogState();
}

class _MyCatalogState extends State<MyCatalog> {
  List<Item> productsCatalog = [
    Item('Shampoo', 10.0, 2),
    Item('Soap', 12, 3),
    Item('Toothpaste', 40, 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Catalog')),
      body: ListView.builder(
        itemCount: productsCatalog.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.star),
            title: Text('${productsCatalog[index].name} - ${productsCatalog[index].price}'),
            trailing: TextButton(
              onPressed: () {
                context.read<ShoppingCart>().addItem(productsCatalog[index]);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${productsCatalog[index].name} added!'),
                  duration: const Duration(seconds: 1, milliseconds: 100),
                ));
              },
              child: const Text('Add'),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}