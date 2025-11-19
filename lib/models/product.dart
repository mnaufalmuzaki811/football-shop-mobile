// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    String id;
    String name;
    int price;
    String description;
    String category;
    String? thumbnail;
    String discount;
    int stock;
    DateTime createdAt;
    DateTime updateAt;
    bool isFeatured;
    int userId;

    Product({
        required this.id,
        required this.name,
        required this.price,
        required this.description,
        required this.category,
        this.thumbnail,
        required this.discount,
        required this.stock,
        required this.createdAt,
        required this.updateAt,
        required this.isFeatured,
        required this.userId,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        discount: json["discount"],
        stock: json["stock"],
        createdAt: DateTime.parse(json["created_at"]),
        updateAt: DateTime.parse(json["update_at"]),
        isFeatured: json["is_featured"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "category": category,
        "thumbnail": thumbnail,
        "discount": discount,
        "stock": stock,
        "created_at": createdAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
        "is_featured": isFeatured,
        "user_id": userId,
    };
}