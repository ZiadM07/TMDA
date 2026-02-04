import '../../../../core/constants/exports.dart';
import '../../../../core/state/app_state.dart';
import '../../domain/entities/session.dart';
import '../../domain/usecases/create_request_token.dart';
import '../../domain/usecases/create_session.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/validate_login.dart';

@injectable
class AuthCubit extends Cubit<AppState<Session>> {
  final CreateRequestToken _createToken;
  final ValidateLogin _validateLogin;
  final CreateSession _createSession;
  final Logout _logout;

  AuthCubit(
    this._createToken,
    this._validateLogin,
    this._createSession,
    this._logout,
  ) : super(const AppState());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(state.copyWith(status: StateStatus.loading));

    try {
      final token = await _createToken();

      final validated = await _validateLogin(
        username: username,
        password: password,
        requestToken: token.token,
      );

      final session = await _createSession(validated.token);

      emit(state.copyWith(status: StateStatus.success, data: session));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error, message: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: StateStatus.loadingOverlay));

    try {
      await _logout();
      emit(const AppState(status: StateStatus.initial));
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error, message: e.toString()));
    }
  }
}
