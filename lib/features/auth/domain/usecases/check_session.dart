import '../../../../core/constants/exports.dart';
import '../repositories/auth_repository.dart';

@injectable
class CheckSession {
  final AuthRepository repository;

  CheckSession(this.repository);

  Future<bool> call() {
    return repository.isAuthenticated();
  }
}
