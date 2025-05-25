import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import '../domain/entities/product.dart';
import '../domain/product_repository.dart';
import 'models/product_model.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final Dio _dio;
  ProductRepositoryImpl(this._dio);

  @override
  Future<List<Product>> fetchProducts({int offset = 0, int limit = 4}) async {
    final resp = await _dio.get(
      '/products',
      queryParameters: {'offset': offset.toString(), 'limit': limit.toString()},
    );
    final list = resp.data as List<dynamic>;

    return list
        .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
