import 'package:exer6/model/item.dart';
import 'package:exer6/provider/shopping_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getItems(context),
          computeCost(),
          const Divider(height: 4, color: Colors.black),
          Flexible(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<ShoppingCart>().removeAll();
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/products');
            },
            child: const Text('Go back to Product Catalog'),
          ),
        ],
      ),
    );
  }

  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart;
    String productName = '';

    return products.isEmpty
        ? const Text('No items yet!')
        : Expanded(
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.food_bank),
                        title: Text(products[index].name),
                        trailing: IconButton(
                          onPressed: () {
                            productName = products[index].name;
                            context
                                .read<ShoppingCart>()
                                .removeItem(productName);

                            if (products.isNotEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('$productName removed'),
                                duration: const Duration(
                                    seconds: 1, milliseconds: 100),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Cart Empty!'),
                                duration:
                                    Duration(seconds: 1, milliseconds: 100),
                              ));
                            }
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }

  Widget computeCost() {
    return Consumer<ShoppingCart>(
      builder:(context, cart, child) {
        return Text('Total: ${cart.cartTotal}');
      },
    );
  }
}
