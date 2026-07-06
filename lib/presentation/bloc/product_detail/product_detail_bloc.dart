import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_product_management/domain/usecases/get_product.dart';

import 'product_detail_state.dart';

class ProductDetailBloc extends Cubit<ProductDetailState> {
  final GetProduct getProduct;

  ProductDetailBloc(this.getProduct)
      : super(ProductDetailState.initial());

  Future<void> load(int id) async {
    emit(state.copyWith(isLoading: true, error: null));

    final result = await getProduct(id);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          error: failure.message,
        ));
      },
      (product) {
        emit(state.copyWith(
          isLoading: false,
          product: product,
        ));
      },
    );
  }
}