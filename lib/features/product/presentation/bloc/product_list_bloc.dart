import 'package:bloc/bloc.dart';
import 'package:lyqx_test/features/product/domain/entities/product.dart';
import '../../domain/product_repository.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepository _repo;
  static const _pageSize = 4;

  int _offset = 0;

  ProductListBloc(this._repo) : super(ProductListInitial()) {
    on<FetchProducts>(_onInit);
    on<FetchMoreProducts>(_onMore);
  }

  Future<void> _onInit(_, Emitter<ProductListState> emit) async {
    emit(ProductListLoading());
    _offset = 0;
    try {
      final page = await _repo.fetchProducts(offset: _offset, limit: _pageSize);
      emit(
        ProductListLoaded(
          products: page,
          hasReachedMax: page.length < _pageSize,
        ),
      );
      _offset += page.length;
    } catch (e) {
      emit(ProductListError(e.toString()));
    }
  }

  Future<void> _onMore(_, Emitter<ProductListState> emit) async {
    final curr = state;
    if (curr is! ProductListLoaded || curr.hasReachedMax) return;

    try {
      final page = await _repo.fetchProducts(offset: _offset, limit: _pageSize);
      final all = List<Product>.from(curr.products)..addAll(page);
      emit(
        ProductListLoaded(
          products: all,
          hasReachedMax: page.length < _pageSize,
        ),
      );
      _offset += page.length;
    } catch (e) {
      emit(ProductListError(e.toString()));
    }
  }
}
