import 'package:tmda/features/movies/domain/entities/genre.dart';

class MovieDetails {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final int runtime;
  final String releaseDate;
  final List<Genre> genres;
  final String originalLanguage;
  const MovieDetails({
    required this.id,
    required this.title,
    this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,
    required this.releaseDate,
    required this.genres,
    required this.originalLanguage,
  });
}
