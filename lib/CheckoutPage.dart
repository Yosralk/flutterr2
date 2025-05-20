import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final TextEditingController addressController = TextEditingController();
  String paymentMethod = "كاش عند التوصيل";

  void placeOrder() {
    if (addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("الرجاء إدخال عنوان التوصيل")),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("تم تأكيد الطلب بنجاح")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الدفع والتوصيل"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: addressController,
              decoration: const InputDecoration(labelText: "عنوان التوصيل"),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: paymentMethod,
              items: [
                "كاش عند التوصيل",
                "بطاقة ائتمان ",
                "PayPal"
              ].map((method) {
                return DropdownMenuItem(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  paymentMethod = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: placeOrder,
              child: const Text("إتمام الطلب"),
            ),
          ],
        ),
      ),
    );
  }
}