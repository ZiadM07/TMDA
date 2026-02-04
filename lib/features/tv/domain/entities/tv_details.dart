import 'package:tmda/features/tv/domain/entities/tv_genre.dart';

class TvDetails {
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final int numberOfSeasons;
  final String firstAirDate;
  final int numberOfEpisodes;
  final int voteCount;
  final List<TvGenre> genres;
  const TvDetails({
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
}
