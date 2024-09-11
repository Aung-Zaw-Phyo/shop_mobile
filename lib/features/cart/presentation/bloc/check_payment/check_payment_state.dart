import 'package:equatable/equatable.dart';

class CheckPaymentState extends Equatable {
  const CheckPaymentState();

  @override
  List<Object?> get props => [];
}

class CheckPaymentInitial extends CheckPaymentState {
  const CheckPaymentInitial();
}

class CheckPaymentLoading extends CheckPaymentState {
  const CheckPaymentLoading();
}

class CheckPaymentLoaded extends CheckPaymentState {
  final int orderId;
  const CheckPaymentLoaded(this.orderId);

  @override
  List<Object> get props => [orderId];
}

class CheckPaymentFailed extends CheckPaymentState {
  final List<String> errors;
  const CheckPaymentFailed(this.errors);

  @override
  List<Object> get props => [errors];
}
