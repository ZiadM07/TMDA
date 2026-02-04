import '../../domain/entities/watchlist_tv.dart';

class WatchlistTvModel extends WatchlistTv {
  const WatchlistTvModel({
    required super.id,
    required super.name,
    super.posterPath,
    required super.voteAverage,
    required super.voteCount,
    required super.firstAirDate,
  });

  factory WatchlistTvModel.fromJson(Map<String, dynamic> json) {
    return WatchlistTvModel(
      id: json['id'],
      name: json['name'],
      posterPath: json['poster_path'],
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      firstAirDate: json['first_air_date'] ?? '',
    );
  }
}
