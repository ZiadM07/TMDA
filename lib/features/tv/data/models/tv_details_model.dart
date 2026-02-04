import 'package:tmda/features/tv/domain/entities/tv_genre.dart';

import '../../domain/entities/tv_details.dart';

class TvDetailsModel {
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int numberOfSeasons;
  final String firstAirDate;
  final int numberOfEpisodes;
  final int voteCount;
  final List<TvGenre> genres;
  TvDetailsModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.numberOfSeasons,
    required this.firstAirDate,
    required this.numberOfEpisodes,
    required this.voteCount,
    required this.genres,
  });

  factory TvDetailsModel.fromJson(Map<String, dynamic> json) {
    return TvDetailsModel(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      numberOfSeasons: json['number_of_seasons'],
      firstAirDate: json['first_air_date'],
      numberOfEpisodes: json['number_of_episodes'],
      voteCount: json['vote_count'],
      genres:
          (json['genres'] as List<dynamic>?)
              ?.map((g) => TvGenre(id: g['id'], name: g['name']))
              .toList() ??
          [],
    );
  }
}

extension TvDetailsMapper on TvDetailsModel {
  TvDetails toEntity() {
    return TvDetails(
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath ?? '',
      backdropPath: backdropPath ?? '',
      voteAverage: voteAverage,
      numberOfSeasons: numberOfSeasons,
      firstAirDate: firstAirDate,
      numberOfEpisodes: numberOfEpisodes,
      voteCount: voteCount,
      genres: genres,
    );
  }
}
