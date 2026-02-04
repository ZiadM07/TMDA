import '../entities/paginated_movies.dart';
import '../repositories/movies_repository.dart';
import '../../../../core/constants/exports.dart';

@Injectable()
class GetRecommendations {
  final MoviesRepository repository;

  GetRecommendations(this.repository);

  Future<PaginatedMovies> call(int movieId, {int page = 1}) {
    return repository.getRecommendations(movieId, page: page);
  }
}
