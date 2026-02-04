import '../../../../core/constants/exports.dart';
import '../repositories/auth_repository.dart';

@injectable
class Logout {
  final AuthRepository repository;

  Logout(this.repository);

  Future<void> call() {
    return repository.logout();
  }
}
