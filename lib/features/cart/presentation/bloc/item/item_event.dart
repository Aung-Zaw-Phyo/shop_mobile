import 'package:equatable/equatable.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class AddItem extends ItemEvent {
  final int quantity;
  final int variantId;
  const AddItem({this.quantity = 1, required this.variantId});

  @override
  List<Object> get props => [quantity, variantId];
}

class RemoveItem extends ItemEvent {
  final int quantity;
  final int variantId;
  const RemoveItem({this.quantity = 1, required this.variantId});

  @override
  List<Object> get props => [quantity, variantId];
}
