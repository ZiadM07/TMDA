import 'movie.dart';

class PaginatedMovies {
  final List<Movie> results;
  final int page;
  final int totalPages;

  const PaginatedMovies({
    required this.results,
    required this.page,
    required this.totalPages,
  });

  bool get hasMore => page < totalPages;
}
