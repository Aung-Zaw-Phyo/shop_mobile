import 'package:equatable/equatable.dart';

class VariantEntity extends Equatable {
  final int id;
  final String color;
  final String size;
  final int stock;

  const VariantEntity({
    required this.id,
    required this.color,
    required this.size,
    required this.stock,
  });

  @override
  List<Object?> get props => [id, color, size, stock];
}
