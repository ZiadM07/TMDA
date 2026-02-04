import '../entities/cast_member.dart';
import '../repositories/movies_repository.dart';
import '../../../../core/constants/exports.dart';

@Injectable()
class GetMovieCredits {
  final MoviesRepository repository;

  GetMovieCredits(this.repository);

  Future<List<CastMember>> call(int movieId) {
    return repository.getMovieCredits(movieId);
  }
}
