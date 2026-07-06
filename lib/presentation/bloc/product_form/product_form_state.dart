import 'package:equatable/equatable.dart';

class ProductFormState extends Equatable {
  final String name;
  final String description;
  final double price;

  final bool isSubmitting;
  final bool isSuccess;
  final String? error;

  const ProductFormState({
    required this.name,
    required this.description,
    required this.price,
    required this.isSubmitting,
    required this.isSuccess,
    this.error,
  });

  factory ProductFormState.initial() {
    return const ProductFormState(
      name: '',
      description: '',
      price: 0.0,
      isSubmitting: false,
      isSuccess: false,
    );
  }

  ProductFormState copyWith({
    String? name,
    String? description,
    double? price,
    bool? isSubmitting,
    bool? isSuccess,
    String? error,
  }) {
    return ProductFormState(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        price,
        isSubmitting,
        isSuccess,
        error,
      ];
}