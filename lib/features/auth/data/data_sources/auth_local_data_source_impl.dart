import '../../../../core/constants/exports.dart';
import 'auth_local_data_source.dart';

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final AppPreferences prefs;

  AuthLocalDataSourceImpl(this.prefs);

  @override
  Future<void> saveSessionId(String sessionId) {
    return prefs.setSessionId(sessionId);
  }

  @override
  Future<String> getSessionId() {
    return prefs.getSessionId();
  }

  @override
  Future<void> clearSession() {
    return prefs.clearSession();
  }
}
