import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/movies/domain/entities/movie_video.dart';
import 'package:tmda/features/movies/domain/repositories/movies_repository.dart';

@Injectable()
class GetMovieTrailers {
  final MoviesRepository repository;

  GetMovieTrailers(this.repository);

  Future<List<MovieVideo>> call(int movieId) {
    return repository.getMovieTrailers(movieId);
  }
}
