import 'package:equatable/equatable.dart';

abstract class CheckPaymentEvent extends Equatable {
  const CheckPaymentEvent();

  @override
  List<Object> get props => [];
}

class CheckPayment extends CheckPaymentEvent {
  final String sessionId;
  const CheckPayment(this.sessionId);

  @override
  List<Object> get props => [sessionId];
}
