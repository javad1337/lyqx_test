import 'package:lyqx_test/features/wishlist/domain/wishlist_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishlistRepositoryImpl implements WishlistRepository {
  final SharedPreferences _prefs;
  static const _key = 'wishlist_ids';

  WishlistRepositoryImpl(this._prefs);

  @override
  Future<Set<int>> getFavorites() async {
    final list = _prefs.getStringList(_key) ?? <String>[];
    return list.map(int.parse).toSet();
  }

  @override
  Future<void> toggleFavorite(int productId) async {
    final favorites = await getFavorites();
    if (favorites.contains(productId)) {
      favorites.remove(productId);
    } else {
      favorites.add(productId);
    }

    final asStrings = favorites.map((i) => i.toString()).toList();
    await _prefs.setStringList(_key, asStrings);
  }
}
