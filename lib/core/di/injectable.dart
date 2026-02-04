import 'package:location/location.dart';

import '../api/api_client.dart';
import '../constants/exports.dart';
import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  await getIt.init();
}

@module
abstract class InjectionModule {
  @preResolve
  Future<SharedPreferences> providePrefs() => SharedPreferences.getInstance();

  @lazySingleton
  StorageService storageService(SharedPreferences prefs) =>
      SharedPreferencesService(prefs);

  @lazySingleton
  AppPreferences appPreferences(StorageService storage) =>
      AppPreferences(storage);

  @singleton
  AppRouter router(AppPreferences prefs) => AppRouter(prefs);

  @injectable
  Location get location => Location();

  @lazySingleton
  InternetConnection internetConnection() => InternetConnection();

  @lazySingleton
  Dio dio() {
    final dio = Dio();
    return dio;
  }

  @lazySingleton
  ApiClient apiClient(Dio dio, AppPreferences prefs) => ApiClient(dio, prefs);
}
