import 'package:tmda/features/movies/domain/entities/movie.dart';
import 'package:tmda/features/tv/domain/entities/tv_show.dart';
import 'person.dart';

class SearchResult {
  final List<Movie> movies;
  final List<TvShow> tvShows;
  final List<Person> people;

  const SearchResult({
    required this.movies,
    required this.tvShows,
    required this.people,
  });

  factory SearchResult.empty() =>
      const SearchResult(movies: [], tvShows: [], people: []);

  SearchResult copyWith({
    List<Movie>? movies,
    List<TvShow>? tvShows,
    List<Person>? people,
  }) {
    return SearchResult(
      movies: movies ?? this.movies,
      tvShows: tvShows ?? this.tvShows,
      people: people ?? this.people,
    );
  }
}
