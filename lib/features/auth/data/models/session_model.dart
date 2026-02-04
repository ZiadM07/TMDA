import '../../domain/entities/session.dart';

class SessionModel extends Session {
  const SessionModel({required super.sessionId, required super.success});

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      sessionId: json['session_id'],
      success: json['success'],
    );
  }
}
