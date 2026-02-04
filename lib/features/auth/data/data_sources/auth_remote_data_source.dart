import '../models/request_token_model.dart';
import '../models/session_model.dart';

abstract class AuthRemoteDataSource {
  Future<RequestTokenModel> createRequestToken();

  Future<RequestTokenModel> validateWithLogin({
    required String username,
    required String password,
    required String requestToken,
  });

  Future<SessionModel> createSession(String requestToken);
}
