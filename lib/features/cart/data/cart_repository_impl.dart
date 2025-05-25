import 'package:lyqx_test/features/cart/domain/cart_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CartRepositoryImpl implements CartRepository {
  static const _key = 'cart_items';

  final SharedPreferences _prefs;
  CartRepositoryImpl(this._prefs);

  Future<Map<int,int>> getCartItems() async {
    final list = _prefs.getStringList(_key) ?? [];
    return {
      for (var e in list)
        if (e.contains(':'))
          int.parse(e.split(':')[0]) : int.parse(e.split(':')[1])
    };
  }

  Future<void> _write(Map<int,int> map) async {
    final asStrings = map.entries.map((e) => '${e.key}:${e.value}').toList();
    await _prefs.setStringList(_key, asStrings);
  }

  @override
  Future<void> addToCart(int productId) async {
    final items = await getCartItems();
    items[productId] = (items[productId] ?? 0) + 1;
    await _write(items);
  }

  @override
  Future<void> removeFromCart(int productId) async {
    final items = await getCartItems();
    items.remove(productId);
    await _write(items);
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    final items = await getCartItems();
    if (quantity <= 0) {
      items.remove(productId);
    } else {
      items[productId] = quantity;
    }
    await _write(items);
  }
}