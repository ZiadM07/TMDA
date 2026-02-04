class WatchlistMovie {
  final int id;
  final String title;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;
  final String releaseDate;

  const WatchlistMovie({
    required this.id,
    required this.title,
    this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.releaseDate,
  });
}
