import 'package:flutter/material.dart';
import '../models.dart';
import 'cart.dart';
import 'history.dart';

class TributeSelectionScreen extends StatefulWidget {
  @override
  State<TributeSelectionScreen> createState() => _TributeSelectionScreenState();
}

class _TributeSelectionScreenState extends State<TributeSelectionScreen> {
  final List<TributeItem> catalog = [
    TributeItem(name: 'Money', price: 100, image: 'assets/money.png'),
    TributeItem(name: '1st Package', price: 150, image: 'assets/package.png'),
    TributeItem(name: 'Gold', price: 100, image: 'assets/gold.png'),
    TributeItem(name: 'Car', price: 75, image: 'assets/car.png'),
    TributeItem(name: 'Clothes', price: 150, image: 'assets/clothes.png'),
    TributeItem(name: 'House', price: 200, image: 'assets/house.png'),
    TributeItem(name: 'Shoes', price: 80, image: 'assets/shoes.png'),
    TributeItem(name: 'Paper Electrical Appliances', price: 100, image: 'assets/electronics.png',),
  ];

  final List<TributeItem> cart = [];
  final List<TributeHistory> history = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🧧 Select Tributes'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HistoryScreen(history: history),
                  ),
                ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: catalog.length,
        itemBuilder: (_, index) {
          final item = catalog[index];
          return ListTile(
            leading: Image.asset(item.image, width: 50),
            title: Text(item.name),
            subtitle: Text('${item.price} Baht'),
            trailing: ElevatedButton(
              child: Text('Add'),
              onPressed: () => setState(() => cart.add(item)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CartScreen(cart: cart, history: history),
            ),
          );
          if (result is List<TributeItem>) {
            setState(() {
              cart.clear();
              cart.addAll(result);
            });
          }
        },
      ),
    );
  }
}
