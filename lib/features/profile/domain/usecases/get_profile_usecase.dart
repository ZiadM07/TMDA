import '../entities/profile.dart';
import '../repositories/profile_repository.dart';
import '../../../../core/constants/exports.dart';

@Injectable()
class GetProfileUsecase {
  final ProfileRepository repository;

  GetProfileUsecase(this.repository);

  Future<Profile> call() {
    return repository.getProfile();
  }
}
