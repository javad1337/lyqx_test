part of 'cart_cubit.dart';

class CartState extends Equatable {
  final Map<int, int> items;
  const CartState({required this.items});
  @override
  List<Object?> get props => [items];
}
