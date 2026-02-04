class RequestToken {
  final String token;
  final bool success;
  final DateTime expiresAt;

  const RequestToken({
    required this.token,
    required this.success,
    required this.expiresAt,
  });
}
