import 'package:equatable/equatable.dart';
import 'package:merchant_product_management/domain/entities/product.dart';

class ProductDetailState extends Equatable {
  final Product? product;
  final bool isLoading;
  final String? error;

  const ProductDetailState({
    required this.product,
    required this.isLoading,
    this.error,
  });

  factory ProductDetailState.initial() {
    return const ProductDetailState(
      product: null,
      isLoading: false,
    );
  }

  ProductDetailState copyWith({
    Product? product,
    bool? isLoading,
    String? error,
  }) {
    return ProductDetailState(
      product: product ?? this.product,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [product, isLoading, error];
}