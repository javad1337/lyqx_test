import 'entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts({int offset = 0, int limit = 4});
}
