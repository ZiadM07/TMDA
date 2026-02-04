import 'package:tmda/features/watchlist/domain/entities/watchlist_movie.dart';
import 'package:tmda/features/watchlist/domain/entities/watchlist_tv.dart';

abstract class WatchlistRepository {
  Future<List<WatchlistMovie>> getWatchlistMovies();
  Future<List<WatchlistTv>> getWatchlistTv();

  Future<void> addToWatchlist({
    required int mediaId,
    required String mediaType, // movie | tv
  });

  Future<void> removeFromWatchlist({
    required int mediaId,
    required String mediaType,
  });
}
