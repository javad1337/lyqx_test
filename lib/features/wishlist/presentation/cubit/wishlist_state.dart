part of 'wishlist_cubit.dart';

class WishlistState extends Equatable {
  final Set<int> favorites;
  const WishlistState({required this.favorites});

  const WishlistState.empty() : favorites = const {};

  @override
  List<Object?> get props => [favorites];
}
