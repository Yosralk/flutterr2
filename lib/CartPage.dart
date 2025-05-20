import 'package:flutter/material.dart';
import'CheckoutPage.dart';

List<Map<String, dynamic>> cart = [];

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double get totalPrice {
    double total = 0;
    for (var item in cart) {
      total += double.parse(item["price"]);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F3),
      appBar: AppBar(
        title: const Text("السلة"),
        backgroundColor: Colors.teal,
      ),
      body: cart.isEmpty
          ? const Center(child: Text("السلة فارغة"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return ListTile(
                  leading: Image.network(item["image"], width: 50, height: 50),
                  title: Text(item["name"]),
                  subtitle: Text("Price: ${item["price"]}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        cart.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Text("الإجمالي: \$${totalPrice.toStringAsFixed(2)}"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutPage()));
            },
            child: const Text("الانتقال للدفع"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}