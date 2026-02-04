import '../entities/movie_details.dart';
import '../repositories/movies_repository.dart';
import '../../../../core/constants/exports.dart';

@Injectable()
class GetMovieDetails {
  final MoviesRepository repository;

  GetMovieDetails(this.repository);

  Future<MovieDetails> call(int movieId) {
    return repository.getMovieDetails(movieId);
  }
}
