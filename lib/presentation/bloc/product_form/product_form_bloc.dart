import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_product_management/domain/entities/product.dart';
import 'package:merchant_product_management/domain/usecases/create_product.dart';
import 'package:merchant_product_management/domain/usecases/update_product.dart';

import 'product_form_state.dart';

class ProductFormBloc extends Cubit<ProductFormState> {
  final CreateProduct createProduct;
  final UpdateProduct updateProduct;

  ProductFormBloc(
    this.createProduct,
    this.updateProduct,
  ) : super(ProductFormState.initial());

  void updateName(String value) {
    emit(state.copyWith(name: value));
  }

  void updateDescription(String value) {
    emit(state.copyWith(description: value));
  }

  void updatePrice(double value) {
    emit(state.copyWith(price: value));
  }

  // -------------------------
  // CREATE
  // -------------------------
  Future<void> submitCreate() async {
    emit(state.copyWith(isSubmitting: true));

    final product = Product(
      id: null,
      name: state.name,
      description: state.description,
      price: state.price,
      updatedAt: DateTime.now(),
      isDirty: true,
      isDeleted: false,
    );

    final result = await createProduct(product);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isSubmitting: false,
          error: failure.message,
        ));
      },
      (_) {
        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: true,
        ));
      },
    );
  }

  // -------------------------
  // UPDATE
  // -------------------------
  Future<void> submitUpdate(int id) async {
    emit(state.copyWith(isSubmitting: true));

    final product = Product(
      id: id,
      name: state.name,
      description: state.description,
      price: state.price,
      updatedAt: DateTime.now(),
      isDirty: true,
      isDeleted: false,
    );

    final result = await updateProduct(product);

    result.fold(
      (failure) {
        emit(state.copyWith(
          isSubmitting: false,
          error: failure.message,
        ));
      },
      (_) {
        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: true,
        ));
      },
    );
  }
}