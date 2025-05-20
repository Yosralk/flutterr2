import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:uuid/uuid.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  // التصنيفات
  final List<String> categories = [
    "الأدوية",
    "العناية بالبشرة",
    "الفيتامينات",
    "المكملات الغذائية",
    "الإسعافات الأولية",
  ];

  String selectedCategory = "الأدوية"; // افتراضي

  void addProduct() async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        imageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("الرجاء تعبئة جميع الحقول")),
      );
      return;
    }

    await FirebaseFirestore.instance.collection("products").add({
      "name": nameController.text,
      "price": priceController.text,
      "image": imageController.text,
      "category": selectedCategory,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تم إضافة المنتج بنجاح")),
    );

    // تفريغ الحقول
    nameController.clear();
    priceController.clear();
    imageController.clear();
    setState(() {
      selectedCategory = categories[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة تحكم المسؤول"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "اسم المنتج"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "سعر المنتج"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: imageController,
                decoration: const InputDecoration(labelText: "رابط صورة المنتج"),
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedCategory,
                isExpanded: true,
                items: categories.map((cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Text(cat),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: addProduct,
                child: const Text("إضافة المنتج"),
              ),
              const SizedBox(height: 20),
              const Text("جميع المنتجات:", style: TextStyle(fontWeight: FontWeight.bold)),

              // عرض المنتجات
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection("products").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const CircularProgressIndicator();
                  final docs = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      var product = docs[index];
                      return ListTile(
                        leading: Image.network(product['https://www.heinens.com/content/uploads/2022/08/Heinens-Health-And-Beauty-products-800x550-1.jpg'], width: 50, height: 50),
                        title: Text(product['name']),
                        subtitle: Text("السعر: ${product['price']} | التصنيف: ${product['category']}"),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            await FirebaseFirestore.instance.collection("products").doc(product.id).delete();
                          },
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}