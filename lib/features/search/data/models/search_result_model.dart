import 'package:tmda/features/movies/data/models/movie_model.dart';
import 'package:tmda/features/tv/data/models/tv_show_model.dart';
import 'package:tmda/features/search/domain/entities/search_result.dart';
import 'package:tmda/features/search/data/models/person_model.dart';

class SearchResultModel {
  final List<MovieModel> movies;
  final List<TvShowModel> tvShows;
  final List<PersonModel> people;

  const SearchResultModel({
    required this.movies,
    required this.tvShows,
    required this.people,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    final results = json['results'] as List<dynamic>;

    final movies = <MovieModel>[];
    final tvShows = <TvShowModel>[];
    final people = <PersonModel>[];

    for (final item in results) {
      switch (item['media_type']) {
        case 'movie':
          movies.add(MovieModel.fromJson(item));
          break;
        case 'tv':
          tvShows.add(TvShowModel.fromJson(item));
          break;
        case 'person':
          people.add(PersonModel.fromJson(item));
          break;
      }
    }

    return SearchResultModel(movies: movies, tvShows: tvShows, people: people);
  }

  SearchResult toEntity() {
    return SearchResult(
      movies: movies.map((e) => e.toEntity()).toList(),
      tvShows: tvShows.map((e) => e.toEntity()).toList(),
      people: people.map((e) => e.toEntity()).toList(),
    );
  }
}
