import '../entities/paginated_movies.dart';
import '../repositories/movies_repository.dart';
import '../../../../core/constants/exports.dart';

@Injectable()
class GetSimilar {
  final MoviesRepository repository;

  GetSimilar(this.repository);

  Future<PaginatedMovies> call(int movieId, {int page = 1}) {
    return repository.getSimilar(movieId, page: page);
  }
}
