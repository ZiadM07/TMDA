import 'movie_model.dart';
import '../../domain/entities/paginated_movies.dart';

class PaginatedMoviesModel extends PaginatedMovies {
  const PaginatedMoviesModel({
    required List<MovieModel> super.results,
    required super.page,
    required super.totalPages,
  });

  factory PaginatedMoviesModel.fromJson(Map<String, dynamic> json) {
    final results =
        (json['results'] as List<dynamic>?)
            ?.map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];
    return PaginatedMoviesModel(
      results: results,
      page: json['page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
    );
  }
}
