import '../entities/request_token.dart';
import '../entities/session.dart';

abstract class AuthRepository {
  Future<RequestToken> createRequestToken();

  Future<RequestToken> validateWithLogin({
    required String username,
    required String password,
    required String requestToken,
  });

  Future<Session> createSession(String requestToken);
  Future<void> logout();
  Future<String> getSessionId();
  Future<bool> isAuthenticated();
}
