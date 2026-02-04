import '../constants/exports.dart';

abstract class StorageService {
  Future<bool> save(String key, dynamic value);
  T get<T>(String key, T defaultValue);
  Future<bool> remove(String key);
}

class SharedPreferencesService implements StorageService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  @override
  Future<bool> save(String key, dynamic value) async {
    if (value is String) return await _prefs.setString(key, value);
    if (value is int) return await _prefs.setInt(key, value);
    if (value is bool) return await _prefs.setBool(key, value);
    if (value is double) return await _prefs.setDouble(key, value);
    if (value is List<String>) return await _prefs.setStringList(key, value);
    throw UnsupportedError("Unsupported value type: ${value.runtimeType}");
  }

  @override
  T get<T>(String key, T defaultValue) {
    final value = _prefs.get(key);
    return value is T ? value : defaultValue;
  }

  @override
  Future<bool> remove(String key) => _prefs.remove(key);
}
