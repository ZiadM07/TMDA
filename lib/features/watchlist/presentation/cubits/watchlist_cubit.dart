import 'package:tmda/core/constants/exports.dart';

import 'package:tmda/features/watchlist/domain/entities/watchlist_movie.dart';
import 'package:tmda/features/watchlist/domain/entities/watchlist_tv.dart';
import 'package:tmda/features/watchlist/domain/usecases/add_to_watchlist.dart';
import 'package:tmda/features/watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:tmda/features/watchlist/domain/usecases/get_watchlist_tv.dart';
import 'package:tmda/features/watchlist/domain/usecases/remove_from_watchlist.dart';

enum WatchlistStatus { none, loading, ready, error }

class WatchlistState extends Equatable {
  final WatchlistStatus status;
  final String? message;
  final int version;

  const WatchlistState({
    this.status = WatchlistStatus.none,
    this.message,
    this.version = 0,
  });

  WatchlistState copyWith({
    WatchlistStatus? status,
    String? message,
    int? version,
  }) {
    return WatchlistState(
      status: status ?? this.status,
      message: message ?? this.message,
      version: version ?? this.version,
    );
  }

  @override
  List<Object?> get props => [status, message, version];
}

@injectable
class WatchlistCubit extends Cubit<WatchlistState> {
  final GetWatchlistMovies getMovies;
  final GetWatchlistTv getTv;
  final AddToWatchlist addToWatchlist;
  final RemoveFromWatchlist removeFromWatchlist;

  WatchlistCubit(
    this.getMovies,
    this.getTv,
    this.addToWatchlist,
    this.removeFromWatchlist,
  ) : super(const WatchlistState());

  // ================= INTERNAL STORAGE =================

  final List<WatchlistMovie> _movies = [];
  final List<WatchlistTv> _tvShows = [];

  final Set<int> _movieIds = {};
  final Set<int> _tvIds = {};

  bool _isReady = false;

  // ================= PUBLIC READ =================

  bool get isReady => _isReady;

  List<WatchlistMovie> get movies => List.unmodifiable(_movies);
  List<WatchlistTv> get tvShows => List.unmodifiable(_tvShows);

  bool isMovieSaved(int id) => _movieIds.contains(id);
  bool isTvSaved(int id) => _tvIds.contains(id);

  // ================= LOAD =================

  Future<void> load() async {
    emit(state.copyWith(status: WatchlistStatus.loading));

    try {
      final results = await Future.wait([getMovies(), getTv()]);

      _movies
        ..clear()
        ..addAll(results[0] as List<WatchlistMovie>);

      _tvShows
        ..clear()
        ..addAll(results[1] as List<WatchlistTv>);

      _movieIds
        ..clear()
        ..addAll(_movies.map((e) => e.id));

      _tvIds
        ..clear()
        ..addAll(_tvShows.map((e) => e.id));

      _isReady = true;
      _emitReady();
    } catch (e) {
      _isReady = true; // fail gracefully
      _emitReady();
    }
  }

  // ================= TOGGLE MOVIE =================

  Future<void> toggleMovie(WatchlistMovieInput movie) async {
    if (!_isReady) return;

    final isSaved = _movieIds.contains(movie.id);

    // 🔥 OPTIMISTIC UPDATE
    if (isSaved) {
      _removeMovie(movie.id);
    } else {
      _addMovie(movie);
    }

    _emitReady();

    try {
      if (isSaved) {
        await removeFromWatchlist(movie.id, 'movie');
      } else {
        await addToWatchlist(movie.id, 'movie');
        _refreshMoviesInBackground();
      }
    } catch (_) {
      // 🔥 ROLLBACK
      if (isSaved) {
        _addMovie(movie);
      } else {
        _removeMovie(movie.id);
      }

      _emitError('Failed to update watchlist');
    }
  }

  // ================= TOGGLE TV =================

  Future<void> toggleTv(WatchlistTvInput tv) async {
    if (!_isReady) return;

    final isSaved = _tvIds.contains(tv.id);

    if (isSaved) {
      _removeTv(tv.id);
    } else {
      _addTv(tv);
    }

    _emitReady();

    try {
      if (isSaved) {
        await removeFromWatchlist(tv.id, 'tv');
      } else {
        await addToWatchlist(tv.id, 'tv');
        _refreshTvInBackground();
      }
    } catch (_) {
      if (isSaved) {
        _addTv(tv);
      } else {
        _removeTv(tv.id);
      }

      _emitError('Failed to update watchlist');
    }
  }

  // ================= BACKGROUND REFRESH =================

  Future<void> _refreshMoviesInBackground() async {
    try {
      final movies = await getMovies();

      _movies
        ..clear()
        ..addAll(movies);

      _movieIds
        ..clear()
        ..addAll(movies.map((e) => e.id));

      _emitReady();
    } catch (_) {}
  }

  Future<void> _refreshTvInBackground() async {
    try {
      final tv = await getTv();

      _tvShows
        ..clear()
        ..addAll(tv);

      _tvIds
        ..clear()
        ..addAll(tv.map((e) => e.id));

      _emitReady();
    } catch (_) {}
  }

  // ================= HELPERS =================

  void _addMovie(WatchlistMovieInput movie) {
    _movieIds.add(movie.id);
    _movies.insert(
      0,
      WatchlistMovie(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        voteAverage: movie.voteAverage,
        voteCount: movie.voteCount,
        releaseDate: movie.releaseDate ?? '',
      ),
    );
  }

  void _removeMovie(int id) {
    _movieIds.remove(id);
    _movies.removeWhere((e) => e.id == id);
  }

  void _addTv(WatchlistTvInput tv) {
    _tvIds.add(tv.id);
    _tvShows.insert(
      0,
      WatchlistTv(
        id: tv.id,
        name: tv.name,
        posterPath: tv.posterPath,
        voteAverage: tv.voteAverage,
        voteCount: tv.voteCount,
        firstAirDate: tv.firstAirDate ?? '',
      ),
    );
  }

  void _removeTv(int id) {
    _tvIds.remove(id);
    _tvShows.removeWhere((e) => e.id == id);
  }

  // ================= EMIT =================

  void _emitReady() {
    emit(
      state.copyWith(status: WatchlistStatus.ready, version: state.version + 1),
    );
  }

  void _emitError(String message) {
    emit(
      state.copyWith(
        status: WatchlistStatus.error,
        message: message,
        version: state.version + 1,
      ),
    );
  }
}

class WatchlistMovieInput {
  final int id;
  final String title;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;
  final String? releaseDate;

  const WatchlistMovieInput({
    required this.id,
    required this.title,
    this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    this.releaseDate,
  });
}

class WatchlistTvInput {
  final int id;
  final String name;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;
  final String? firstAirDate;

  const WatchlistTvInput({
    required this.id,
    required this.name,
    this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    this.firstAirDate,
  });
}
