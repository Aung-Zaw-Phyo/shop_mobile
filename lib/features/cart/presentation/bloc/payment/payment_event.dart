import 'package:equatable/equatable.dart';
import 'package:shop_mobile/features/cart/domain/entities/shipping_address.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class CreatePayment extends PaymentEvent {
  final ShippingAddressEntity shippingAddressEntity;
  const CreatePayment(this.shippingAddressEntity);

  @override
  List<Object> get props => [shippingAddressEntity];
}
