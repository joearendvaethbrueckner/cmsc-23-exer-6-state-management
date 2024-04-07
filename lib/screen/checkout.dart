import 'package:exer6/model/item.dart';
import 'package:exer6/provider/shopping_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Column(
        children: [
          const Text('Item Details'),
          const Divider(),
          getCheckout(context),
        ],
      ),
    );
  }

  Widget getCheckout(BuildContext context) {
    List<Item> cart = context.watch<ShoppingCart>().cart;
    double total = context.read<ShoppingCart>().cartTotal;
    return cart.isEmpty
        ? const Text('No items to checkout!')
        : Expanded(
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(cart[index].name),
                        trailing: Text(cart[index].price.toString()),
                      );
                    },
                  ),
                ),
                const Divider(),
                Flexible(
                  child: Column(
                    children: [
                      Text('Total Cost to Pay: $total'),
                      cart.isEmpty
                          ? const SizedBox()
                          : ElevatedButton(
                              onPressed: () {
                                context.read<ShoppingCart>().removeAll();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Payment Successful'),
                                ));
                              },
                              child: const Text('Pay Now!'),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
