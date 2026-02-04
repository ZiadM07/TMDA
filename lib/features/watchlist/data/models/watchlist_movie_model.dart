import '../../domain/entities/watchlist_movie.dart';

class WatchlistMovieModel extends WatchlistMovie {
  const WatchlistMovieModel({
    required super.id,
    required super.title,
    super.posterPath,
    required super.voteAverage,
    required super.voteCount,
    required super.releaseDate,
  });

  factory WatchlistMovieModel.fromJson(Map<String, dynamic> json) {
    return WatchlistMovieModel(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      releaseDate: json['release_date'] ?? '',
    );
  }
}
