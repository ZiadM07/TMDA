  import '../../domain/entities/movie_details.dart';
import 'genre_model.dart';

class MovieDetailsModel extends MovieDetails {
  const MovieDetailsModel({
    required super.id,
    required super.title,
    super.overview,
    super.posterPath,
    super.backdropPath,
    required super.voteAverage,
    required super.voteCount,
    required super.runtime,
    required super.genres,
    required super.releaseDate,
    required super.originalLanguage,
  });

factory MovieDetailsModel.fromJson(Map<String, dynamic> json) {
  final genres =
      (json['genres'] as List<dynamic>?)
          ?.map((g) => GenreModel.fromJson(g as Map<String, dynamic>))
          .toList() ??
      [];

  return MovieDetailsModel(
    id: json['id'],
    title: json['title'] ?? '',
    overview: json['overview'],
    posterPath: json['poster_path'],
    backdropPath: json['backdrop_path'],
    voteAverage: (json['vote_average'] ?? 0).toDouble(),
    voteCount: json['vote_count'] ?? 0,
    runtime: json['runtime'] ?? 0,
    genres: genres,
    releaseDate: json['release_date'] ?? '',
    originalLanguage: json['original_language']?.toUpperCase() ?? '',
  );
}

}
