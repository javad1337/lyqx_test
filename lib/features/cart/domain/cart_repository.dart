abstract class CartRepository {
  Future<Map<int, int>> getCartItems();

  Future<void> addToCart(int productId);

  Future<void> removeFromCart(int productId);

  Future<void> updateQuantity(int productId, int quantity);
}
