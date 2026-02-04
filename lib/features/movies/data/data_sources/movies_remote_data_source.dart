import 'package:tmda/features/movies/data/models/movie_video_model.dart';

import '../models/paginated_movies_model.dart';
import '../models/movie_details_model.dart';
import '../models/cast_model.dart';

abstract class MoviesRemoteDataSource {
  Future<PaginatedMoviesModel> fetchNowPlaying({int page = 1});
  Future<PaginatedMoviesModel> fetchPopular({int page = 1});
  Future<PaginatedMoviesModel> fetchTopRated({int page = 1});

  Future<MovieDetailsModel> fetchMovieDetails(int movieId);
  Future<List<CastModel>> fetchMovieCredits(int movieId);

  Future<PaginatedMoviesModel> fetchRecommendations(
    int movieId, {
    int page = 1,
  });
  Future<PaginatedMoviesModel> fetchSimilar(int movieId, {int page = 1});
    Future<List<MovieVideoModel>> fetchMovieTrailers(int movieId);
}
