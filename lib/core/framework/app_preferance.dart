import '../constants/exports.dart';

class AppPreferences {
  final StorageService storage;

  AppPreferences(this.storage);

  String get language =>
      storage.get<String>(AppConstants.lang, AppConstants.enCode);

  set language(String value) => storage.save(AppConstants.lang, value);

  AppThemeMode get appThemeMode {
    final index = storage.get<int>(
      AppConstants.theme,
      AppThemeMode.system.index,
    );
    return AppThemeMode.values[index];
  }

  set appThemeMode(AppThemeMode value) =>
      storage.save(AppConstants.theme, value.index);

  Future<String> getSessionId() async =>
      storage.get<String>(AppConstants.sessionId, '');

  Future<void> setSessionId(String value) async =>
      await storage.save(AppConstants.sessionId, value);

  Future<void> clearSession() async =>
      await storage.remove(AppConstants.sessionId);

  Future<bool> get isAuthenticated async => (await getSessionId()).isNotEmpty;

  Future<int> getAccountId() async =>
      storage.get<int>(AppConstants.accountId, 0);

  Future<void> setAccountId(int value) async =>
      await storage.save(AppConstants.accountId, value);

  Future<void> clearAccount() async =>
      await storage.remove(AppConstants.accountId);
}
