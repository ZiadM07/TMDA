import '../../../../core/constants/exports.dart';
import '../../../../core/state/app_state.dart';
import '../../domain/usecases/check_session.dart';

@injectable
class StartupCubit extends Cubit<AppState<bool>> {
  final CheckSession _checkSession;

  StartupCubit(this._checkSession)
    : super(const AppState(status: StateStatus.loading));

  Future<void> decideStartRoute() async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      debugPrint('Startup: checking session...');
      final isLoggedIn = await _checkSession();
      debugPrint('Startup: isLoggedIn = $isLoggedIn');

      emit(state.copyWith(status: StateStatus.success, data: isLoggedIn));
    } catch (e, s) {
      debugPrint('Startup error: $e');
      debugPrintStack(stackTrace: s);

      emit(state.copyWith(status: StateStatus.error, message: e.toString()));
    }
  }
}
