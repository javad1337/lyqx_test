import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lyqx_test/features/cart/domain/cart_repository.dart';

part 'cart_state.dart';



class CartCubit extends Cubit<CartState> {
  final CartRepository _repo;
  CartCubit(this._repo) : super(const CartState(items: {}));

  Future<void> loadCart() async {
    final map = await _repo.getCartItems();
    emit(CartState(items: map));
  }

  Future<void> add(int productId) async {
    await _repo.addToCart(productId);
    await loadCart();
  }

  Future<void> remove(int productId) async {
    await _repo.removeFromCart(productId);
    await loadCart();
  }

  Future<void> update(int productId, int qty) async {
    await _repo.updateQuantity(productId, qty);
    await loadCart();
  }
}