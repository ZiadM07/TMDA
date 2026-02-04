import 'package:tmda/features/watchlist/data/models/watchlist_movie_model.dart';
import 'package:tmda/features/watchlist/data/models/watchlist_tv_model.dart';

abstract class WatchlistRemoteDataSource {
  Future<List<WatchlistMovieModel>> getMovies();
  Future<List<WatchlistTvModel>> getTv();

  Future<void> updateWatchlist({
    required int mediaId,
    required String mediaType,
    required bool watchlist,
  });
}
