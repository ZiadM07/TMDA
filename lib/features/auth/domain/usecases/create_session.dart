import '../../../../core/constants/exports.dart';
import '../entities/session.dart';
import '../repositories/auth_repository.dart';

@injectable
class CreateSession {
  final AuthRepository repository;

  CreateSession(this.repository);

  Future<Session> call(String requestToken) {
    return repository.createSession(requestToken);
  }
}
