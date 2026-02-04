import '../entities/paginated_movies.dart';
import '../repositories/movies_repository.dart';
import '../../../../core/constants/exports.dart';

@Injectable()
class GetNowPlaying {
  final MoviesRepository repository;

  GetNowPlaying(this.repository);

  Future<PaginatedMovies> call({int page = 1}) {
    return repository.getNowPlaying(page: page);
  }
}
