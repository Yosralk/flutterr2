import 'package:flutter/material.dart';
import 'package:flutterr2/FavoritesPage.dart';import 'CartPage.dart';

import 'FavoritesPage.dart';
class ProductDetails extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  const ProductDetails({
    super.key,
    required this.name,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F3),
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  image,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              name,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Price: $price",
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    favorites.add({"name": name, "price": price, "image": image});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("تمت الإضافة إلى المفضلة")),
                    );
                  },
                  icon: const Icon(Icons.favorite_border),
                  label: const Text("أضف للمفضلة"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    cart.add({"name": name, "price": price, "image": image});
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("تمت الإضافة إلى السلة")),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_outlined),
                  label: const Text("أضف للسلة"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}