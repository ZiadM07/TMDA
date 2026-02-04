import '../entities/paginated_movies.dart';
import '../repositories/movies_repository.dart';
import '../../../../core/constants/exports.dart';

@Injectable()
class GetTopRated {
  final MoviesRepository repository;

  GetTopRated(this.repository);

  Future<PaginatedMovies> call({int page = 1}) {
    return repository.getTopRated(page: page);
  }
}
