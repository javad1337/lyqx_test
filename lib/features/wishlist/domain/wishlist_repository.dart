abstract class WishlistRepository {
  Future<Set<int>> getFavorites();

  Future<void> toggleFavorite(int productId);
}
