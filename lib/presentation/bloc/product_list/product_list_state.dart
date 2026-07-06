import 'package:equatable/equatable.dart';
import 'package:merchant_product_management/domain/entities/product.dart';

class ProductListState extends Equatable {
  final List<Product> products;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? error;
  final int page;

  const ProductListState({
    required this.products,
    required this.isLoading,
    required this.isLoadingMore,
    required this.hasMore,
    required this.page,
    this.error,
  });

  factory ProductListState.initial() {
    return const ProductListState(
      products: [],
      isLoading: false,
      isLoadingMore: false,
      hasMore: true,
      page: 1,
    );
  }

  ProductListState copyWith({
    List<Product>? products,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? error,
    int? page,
  }) {
    return ProductListState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      error: error,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [
        products,
        isLoading,
        isLoadingMore,
        hasMore,
        error,
        page,
      ];
}