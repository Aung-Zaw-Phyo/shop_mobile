import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<String> messages;
  const Failure({required this.messages});

  @override
  List<Object> get props => [messages];
}

class ServerFailure extends Failure {
  const ServerFailure(List<String> messages) : super(messages: messages);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(List<String> messages) : super(messages: messages);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(List<String> messages) : super(messages: messages);
}
