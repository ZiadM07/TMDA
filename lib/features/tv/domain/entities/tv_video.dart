class TvVideo {
  final String id;
  final String key;
  final String name;
  final String site;
  final String type;

  const TvVideo({
    required this.id,
    required this.key,
    required this.name,
    required this.site,
    required this.type,
  });

  bool get isTrailer => type == 'Trailer' && site == 'YouTube';
}
