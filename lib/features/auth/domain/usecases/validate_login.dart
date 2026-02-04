import '../../../../core/constants/exports.dart';
import '../entities/request_token.dart';
import '../repositories/auth_repository.dart';

@injectable
class ValidateLogin {
  final AuthRepository repository;

  ValidateLogin(this.repository);

  Future<RequestToken> call({
    required String username,
    required String password,
    required String requestToken,
  }) {
    return repository.validateWithLogin(
      username: username,
      password: password,
      requestToken: requestToken,
    );
  }
}
