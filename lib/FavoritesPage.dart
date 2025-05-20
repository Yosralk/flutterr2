import 'package:flutter/material.dart';
import'ProductDetails.dart';




// مفضلة مؤقتة بدون Firebase
List<Map<String, dynamic>> favorites = [];

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F3),
      appBar: AppBar(
        title: const Text("المفضلة"),
        backgroundColor: Colors.teal,
      ),
      body: favorites.isEmpty
          ? const Center(child: Text("لا توجد منتجات في المفضلة"))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final product = favorites[index];
          return Card(
            child: ListTile(
              leading: Image.network(product["image"], width: 50, height: 50),
              title: Text(product["name"]),
              subtitle: Text("Price: ${product["price"]}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    favorites.removeAt(index);
                  });
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetails(
                      name: product["name"],
                      price: product["price"],
                      image: product["image"],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}