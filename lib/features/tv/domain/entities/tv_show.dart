class TvShow {
  final int id;
  final String name;
  final String posterPath;
  final double voteAverage;
  final String firstAirDate;
  final String originalLanguage;
  final int voteCount;

  const TvShow({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.voteAverage,
    required this.firstAirDate,
    required this.originalLanguage,
    required this.voteCount,
  });
}
