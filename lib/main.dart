import 'package:exer6/provider/shopping_cart_provider.dart';
import 'package:exer6/screen/checkout.dart';
import 'package:exer6/screen/my_cart.dart';
import 'package:exer6/screen/my_catalog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ShoppingCart()),
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/cart': (context) => const MyCart(),
        '/products': (context) => const MyCatalog(),
        '/checkout': (context) => const Checkout(),
      },
      home: const MyCatalog(),
    );
  }
}
