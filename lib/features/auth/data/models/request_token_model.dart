import '../../domain/entities/request_token.dart';

class RequestTokenModel extends RequestToken {
  const RequestTokenModel({
    required super.token,
    required super.success,
    required super.expiresAt,
  });

  factory RequestTokenModel.fromJson(Map<String, dynamic> json) {
    return RequestTokenModel(
      token: json['request_token'],
      success: json['success'],
      expiresAt: _parseTmdbDate(json['expires_at']),
    );
  }

  static DateTime _parseTmdbDate(String value) {
    final cleaned = value.replaceAll(' UTC', '');
    return DateTime.parse(cleaned).toUtc();
  }
}
