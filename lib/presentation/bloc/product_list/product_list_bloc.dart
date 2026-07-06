import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_product_management/domain/usecases/get_product.dart';

import 'product_list_state.dart';

class ProductListBloc extends Cubit<ProductListState> {
  final GetProducts getProducts;

  ProductListBloc(this.getProducts)
      : super(ProductListState.initial());

  // -------------------------
  // INITIAL LOAD
  // -------------------------
  Future<void> loadProducts() async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await getProducts(page: 1);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          error: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          isLoading: false,
          products: data.items,
          hasMore: data.hasMore,
          page: 1,
        ));
      },
    );
  }

  // -------------------------
  // PAGINATION
  // -------------------------
  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    emit(state.copyWith(isLoadingMore: true));

    final nextPage = state.page + 1;

    final result = await getProducts(page: nextPage);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoadingMore: false,
          error: failure.message,
        ));
      },
      (data) {
        emit(state.copyWith(
          isLoadingMore: false,
          products: [...state.products, ...data.items],
          page: nextPage,
          hasMore: data.hasMore,
        ));
      },
    );
  }

  // -------------------------
  // REFRESH
  // -------------------------
  Future<void> refresh() async {
    await loadProducts();
  }
}