import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  const AuthLoaded();
}

class AuthFailed extends AuthState {
  final List<String> errors;
  const AuthFailed(this.errors);

  @override
  List<Object> get props => [errors];
}
