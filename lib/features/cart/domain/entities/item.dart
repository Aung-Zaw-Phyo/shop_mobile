import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/cart/domain/entities/variant.dart';

class ItemEntity extends Equatable {
  final int id;
  final int quantity;
  final int amount;
  final VariantEntity variant;
  const ItemEntity({
    required this.id,
    required this.quantity,
    required this.amount,
    required this.variant,
  });

  @override
  List<Object> get props => [id, quantity, amount, variant];
}
