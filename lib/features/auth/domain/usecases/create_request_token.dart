import '../../../../core/constants/exports.dart';
import '../entities/request_token.dart';
import '../repositories/auth_repository.dart';

@injectable
class CreateRequestToken {
  final AuthRepository repository;

  CreateRequestToken(this.repository);

  Future<RequestToken> call() {
    return repository.createRequestToken();
  }
}
