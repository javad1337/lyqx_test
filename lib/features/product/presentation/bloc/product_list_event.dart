import 'package:equatable/equatable.dart';

abstract class ProductListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProducts extends ProductListEvent {} // initial

class FetchMoreProducts extends ProductListEvent {} // next page
