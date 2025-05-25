import '../../domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.title,
    required super.image,
    required super.price,
    required super.rating,
    required super.category,
    required super.reviewCount,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      title: json['title'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating']['rate'] as num).toDouble(),
      category: json['category'] as String,
      reviewCount: json['rating']['count'] as int,
    );
  }
}
