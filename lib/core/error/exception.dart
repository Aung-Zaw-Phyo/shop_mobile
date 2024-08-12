class ServerException implements Exception {
  final List<String> messages;

  const ServerException(this.messages);
}
