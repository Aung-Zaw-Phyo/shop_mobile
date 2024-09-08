import 'package:equatable/equatable.dart';

class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {
  const PaymentInitial();
}

class PaymentLoading extends PaymentState {
  const PaymentLoading();
}

class PaymentLoaded extends PaymentState {
  final String clientSecret;
  const PaymentLoaded(this.clientSecret);

  @override
  List<Object> get props => [clientSecret];
}

class PaymentFailed extends PaymentState {
  final List<String> errors;
  const PaymentFailed(this.errors);

  @override
  List<Object> get props => [errors];
}
