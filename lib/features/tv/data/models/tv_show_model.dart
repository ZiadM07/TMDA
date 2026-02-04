import '../../domain/entities/tv_show.dart';

class TvShowModel {
  final int id;
  final String name;
  final String? posterPath;
  final String? backdropPath;
  final double? voteAverage;
  final String? firstAirDate;
  final String? originalLanguage;
  final int? voteCount;

  TvShowModel({
    required this.id,
    required this.name,
    this.posterPath,
    this.backdropPath,
    this.voteAverage,
    this.firstAirDate,
    this.originalLanguage,
    this.voteCount,
  });

  factory TvShowModel.fromJson(Map<String, dynamic> json) {
    return TvShowModel(
      id: json['id'],
      name: json['name'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      firstAirDate: json['first_air_date'],
      originalLanguage: json['original_language'],
      voteCount: json['vote_count'],
    );
  }
}

extension TvShowMapper on TvShowModel {
  TvShow toEntity() {
    return TvShow(
      id: id,
      name: name,
      posterPath: posterPath ?? '',
      voteAverage: voteAverage ?? 0,
      firstAirDate: firstAirDate ?? '',
      originalLanguage: originalLanguage ?? '',
      voteCount: voteCount ?? 0,
    );
  }
}
