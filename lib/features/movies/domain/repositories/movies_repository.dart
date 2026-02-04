import 'package:tmda/features/movies/domain/entities/movie_video.dart';

import '../entities/paginated_movies.dart';
import '../entities/movie_details.dart';
import '../entities/cast_member.dart';

abstract class MoviesRepository {
  Future<PaginatedMovies> getNowPlaying({int page = 1});
  Future<PaginatedMovies> getPopular({int page = 1});
  Future<PaginatedMovies> getTopRated({int page = 1});

  Future<MovieDetails> getMovieDetails(int movieId);
  Future<List<CastMember>> getMovieCredits(int movieId);

  Future<PaginatedMovies> getRecommendations(int movieId, {int page = 1});
  Future<PaginatedMovies> getSimilar(int movieId, {int page = 1});
  Future<List<MovieVideo>> getMovieTrailers(int movieId);
}
