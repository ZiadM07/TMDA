import 'package:tmda/features/movies/domain/entities/movie_video.dart';

import '../../../../core/constants/exports.dart';
import '../../domain/entities/paginated_movies.dart';
import '../../domain/entities/movie_details.dart';
import '../../domain/entities/cast_member.dart';
import '../../domain/repositories/movies_repository.dart';
import '../data_sources/movies_remote_data_source.dart';

@LazySingleton(as: MoviesRepository)
class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remote;
  MoviesRepositoryImpl(this.remote);

  @override
  Future<PaginatedMovies> getNowPlaying({int page = 1}) async {
    return remote.fetchNowPlaying(page: page);
  }

  @override
  Future<PaginatedMovies> getPopular({int page = 1}) async {
    return remote.fetchPopular(page: page);
  }

  @override
  Future<PaginatedMovies> getTopRated({int page = 1}) async {
    return remote.fetchTopRated(page: page);
  }

  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    return remote.fetchMovieDetails(movieId);
  }

  @override
  Future<List<CastMember>> getMovieCredits(int movieId) {
    return remote.fetchMovieCredits(movieId);
  }

  @override
  Future<PaginatedMovies> getRecommendations(int movieId, {int page = 1}) {
    return remote.fetchRecommendations(movieId, page: page);
  }

  @override
  Future<PaginatedMovies> getSimilar(int movieId, {int page = 1}) {
    return remote.fetchSimilar(movieId, page: page);
  }

  @override
  Future<List<MovieVideo>> getMovieTrailers(int movieId) async {
    final trailers = await remote.fetchMovieTrailers(movieId);
    return trailers.where((trailer) => trailer.isTrailer).toList();
  }
}
