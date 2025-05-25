import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/wishlist_repository.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  final WishlistRepository _repo;

  WishlistCubit(this._repo) : super(const WishlistState.empty());

  Future<void> load() async {
    final favs = await _repo.getFavorites();
    emit(WishlistState(favorites: favs));
  }

  Future<void> toggle(int productId) async {
    await _repo.toggleFavorite(productId);
    final favs = await _repo.getFavorites();
    emit(WishlistState(favorites: favs));
  }
}
