import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int? id;
  final String name;
  final String description;
  final double price;
  final DateTime updatedAt;

  /// Local-only metadata
  final bool isDirty;
  final bool isDeleted;

  const Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.updatedAt,
    this.isDirty = false,
    this.isDeleted = false,
  });

  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    DateTime? updatedAt,
    bool? isDirty,
    bool? isDeleted,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      updatedAt: updatedAt ?? this.updatedAt,
      isDirty: isDirty ?? this.isDirty,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        updatedAt,
        isDirty,
        isDeleted,
      ];
}