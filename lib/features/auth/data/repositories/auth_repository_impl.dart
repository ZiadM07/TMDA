import '../../../../core/constants/exports.dart';
import '../../domain/entities/request_token.dart';
import '../../domain/entities/session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_local_data_source.dart';
import '../data_sources/auth_remote_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  AuthRepositoryImpl(this.remote, this.local);

  @override
  Future<RequestToken> createRequestToken() {
    return remote.createRequestToken();
  }

  @override
  Future<RequestToken> validateWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) {
    return remote.validateWithLogin(
      username: username,
      password: password,
      requestToken: requestToken,
    );
  }

  @override
  Future<Session> createSession(String requestToken) async {
    final session = await remote.createSession(requestToken);
    await local.saveSessionId(session.sessionId);
    return session;
  }

  @override
  Future<void> logout() async {
    await local.clearSession();
  }

  @override
  Future<String> getSessionId() {
    return local.getSessionId();
  }

  @override
  Future<bool> isAuthenticated() {
    return local.getSessionId().then((id) => id.isNotEmpty);
  }
}
