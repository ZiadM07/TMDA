import 'package:tmda/features/tv/domain/entities/tv_show.dart';

class PaginatedTv {
  final int page;
  final int totalPages;
  final List<TvShow> results;

  const PaginatedTv({
    required this.page,
    required this.totalPages,
    required this.results,
  });
}
