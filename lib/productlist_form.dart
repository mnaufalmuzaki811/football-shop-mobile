import 'package:flutter/material.dart';
import 'package:football_shop/left_drawer.dart';
import 'dart:convert';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:football_shop/screens/list_product.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Sesuaikan dengan model kamu
  String _name = "";
  int _price = 0;
  String _description = "";

  // Field opsional
  String _thumbnail = "";
  String? _category;
  bool _isFeatured = false;

  final List<String> _categories = ['Jersey', 'Sepatu', 'Bola', 'Aksesori'];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Create Product')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Name (wajib) ===
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Nama Produk",
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (v) => _name = v.trim(),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return "Name tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),

              // === Price (wajib) ===
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Contoh: 199999",
                  labelText: "Price (integer)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (v) => _price = int.tryParse(v.trim()) ?? 0,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return "Price tidak boleh kosong!";
                  }
                  final p = int.tryParse(v.trim());
                  if (p == null) return "Price harus bilangan bulat!";
                  if (p <= 0) return "Price harus > 0";
                  return null;
                },
              ),
              const SizedBox(height: 8),

              // === Description (wajib) ===
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Deskripsi Produk",
                  labelText: "Description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (v) => _description = v.trim(),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return "Description tidak boleh kosong!";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),

              // === Thumbnail URL (opsional) ===
              TextFormField(
                decoration: InputDecoration(
                  hintText: "URL Thumbnail (opsional)",
                  labelText: "Thumbnail URL",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                keyboardType: TextInputType.url,
                onChanged: (v) => _thumbnail = v.trim(),
              ),
              const SizedBox(height: 8),

              // === Category (opsional) ===
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Category (opsional)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                value: _category,
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v),
              ),
              const SizedBox(height: 8),

              // === Featured (opsional) ===
              SwitchListTile(
                title: const Text("Featured (opsional)"),
                value: _isFeatured,
                onChanged: (val) => setState(() => _isFeatured = val),
              ),
              const SizedBox(height: 12),

              // === Save ===
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                  icon: const Icon(Icons.save),
                  label: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Kirim ke Django dan tunggu respons
                      final response = await request.postJson(
                        "http://10.0.2.2:8000/create-flutter/", // URL View baru tadi
                        jsonEncode(<String, String>{
                          'name': _name,
                          'price': _price.toString(),
                          'description': _description,
                          // Kirim field opsional juga jika ada
                          'category': _category ?? "new",
                          'thumbnail': _thumbnail,
                          'is_featured': _isFeatured.toString(),
                          // Jika model Django membutuhkan field lain seperti stock/discount, tambahkan di sini
                        }),
                      );

                      if (context.mounted) {
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Produk baru berhasil disimpan!"),
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductPage(),
                            ), // Atau kembali ke Menu
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Terdapat kesalahan, silakan coba lagi.",
                              ),
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
