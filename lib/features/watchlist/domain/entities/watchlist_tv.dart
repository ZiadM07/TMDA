class WatchlistTv {
  final int id;
  final String name;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;
  final String firstAirDate;
  

  const WatchlistTv({
    required this.id,
    required this.name,
    this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.firstAirDate,
  });
}
