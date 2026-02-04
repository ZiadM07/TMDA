import 'package:tmda/features/movies/data/models/movie_video_model.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/constants/exports.dart';
import 'movies_remote_data_source.dart';
import '../models/paginated_movies_model.dart';
import '../models/movie_details_model.dart';
import '../models/cast_model.dart';

@LazySingleton(as: MoviesRemoteDataSource)
class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  final ApiClient client;
  MoviesRemoteDataSourceImpl(this.client);

  @override
  Future<PaginatedMoviesModel> fetchNowPlaying({int page = 1}) async {
    final resp = await client.get(
      ApiEndpoints.moviesNowPlaying,
      query: {'page': page},
    );
    return PaginatedMoviesModel.fromJson(resp.data as Map<String, dynamic>);
  }

  @override
  Future<PaginatedMoviesModel> fetchPopular({int page = 1}) async {
    final resp = await client.get(
      ApiEndpoints.moviesPopular,
      query: {'page': page},
    );
    return PaginatedMoviesModel.fromJson(resp.data as Map<String, dynamic>);
  }

  @override
  Future<PaginatedMoviesModel> fetchTopRated({int page = 1}) async {
    final resp = await client.get(
      ApiEndpoints.moviesTopRated,
      query: {'page': page},
    );
    return PaginatedMoviesModel.fromJson(resp.data as Map<String, dynamic>);
  }

  @override
  Future<MovieDetailsModel> fetchMovieDetails(int movieId) async {
    final resp = await client.get(ApiEndpoints.movieDetails(movieId));
    return MovieDetailsModel.fromJson(resp.data as Map<String, dynamic>);
  }

  @override
  Future<List<CastModel>> fetchMovieCredits(int movieId) async {
    final resp = await client.get(ApiEndpoints.movieCredits(movieId));
    final castList =
        (resp.data['cast'] as List<dynamic>?)
            ?.map((e) => CastModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return castList;
  }

  @override
  Future<PaginatedMoviesModel> fetchRecommendations(
    int movieId, {
    int page = 1,
  }) async {
    final resp = await client.get(
      ApiEndpoints.movieRecommendations(movieId),
      query: {'page': page},
    );
    return PaginatedMoviesModel.fromJson(resp.data as Map<String, dynamic>);
  }

  @override
  Future<PaginatedMoviesModel> fetchSimilar(int movieId, {int page = 1}) async {
    final resp = await client.get(
      ApiEndpoints.similarMovies(movieId),
      query: {'page': page},
    );
    return PaginatedMoviesModel.fromJson(resp.data as Map<String, dynamic>);
  }
  @override
Future<List<MovieVideoModel>> fetchMovieTrailers(int movieId) async {
  final resp = await client.get(
    ApiEndpoints.movieVideos(movieId),
  );

  final results = resp.data['results'] as List<dynamic>? ?? [];

  return results
      .map((e) => MovieVideoModel.fromJson(e as Map<String, dynamic>))
      .toList();
}
}
