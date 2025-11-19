import 'package:flutter/material.dart';
import 'package:football_shop/models/product.dart';

class DetailProductPage extends StatelessWidget {
  final Product product;

  const DetailProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // Tampilkan gambar jika ada (opsional)
            if (product.thumbnail != null && product.thumbnail!.isNotEmpty)
              Center(
                child: Image.network(
                  product.thumbnail!,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100, color: Colors.grey),
                ),
              ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Category: ${product.category}",
              style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
            ),
             const SizedBox(height: 10),
            Text(
              "Price: Rp ${product.price}",
              style: const TextStyle(fontSize: 18.0, color: Colors.green),
            ),
            const SizedBox(height: 10),
             Text(
              "Stock: ${product.stock}",
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 20),
            const Text(
              "Description:",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}