import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

abstract class ProductListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListLoaded extends ProductListState {
  final List<Product> products;
  final bool hasReachedMax;

  ProductListLoaded({required this.products, this.hasReachedMax = false});

  @override
  List<Object?> get props => [products, hasReachedMax];
}

class ProductListError extends ProductListState {
  final String message;
  ProductListError(this.message);
  @override
  List<Object?> get props => [message];
}
