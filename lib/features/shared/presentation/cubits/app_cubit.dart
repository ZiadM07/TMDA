import 'dart:math';
import '../../../../core/state/app_state.dart';
import '../../../../core/constants/exports.dart';

@singleton
class AppCubit extends Cubit<AppState> {
  final AppPreferences _preferences;

  late Locale locale;
  late AppThemeMode appThemeMode;
  late ValueNotifier<bool> isArSelected;

  AppCubit(this._preferences) : super(const AppState()) {
    locale = Locale(_preferences.language);
    appThemeMode = _preferences.appThemeMode;
    isArSelected = ValueNotifier(_preferences.language == AppConstants.arCode);
  }

  static int get randomId => Random().nextInt(999999);

  // ----------------------------
  // AUTH (FIXED)
  // ----------------------------
  Future<bool> get isAuthenticated async => await _preferences.isAuthenticated;

  // ----------------------------
  // LANGUAGE
  // ----------------------------
  void changeLang(String lang) {
    locale = Locale(lang);
    _preferences.language = lang;
    isArSelected.value = lang == AppConstants.arCode;
    emit(state.copyWith(data: randomId));
  }

  // ----------------------------
  // THEME
  // ----------------------------
  void changeThemeMode(int index) {
    _preferences.appThemeMode = getAppThemeModeFromIndex(index);
    appThemeMode = _preferences.appThemeMode;
    emit(state.copyWith(data: randomId));
  }

  void applyPlatformThemeMode() {
    if (appThemeMode == AppThemeMode.system) {
      emit(state.copyWith(data: randomId));
    }
  }
}
