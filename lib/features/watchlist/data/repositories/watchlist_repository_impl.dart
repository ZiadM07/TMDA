import 'package:tmda/features/watchlist/data/data_sources/watchlist_remote_datasource.dart';
import 'package:tmda/features/watchlist/domain/entities/watchlist_movie.dart';
import 'package:tmda/features/watchlist/domain/entities/watchlist_tv.dart';
import 'package:tmda/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:tmda/core/constants/exports.dart';
  
@LazySingleton(as: WatchlistRepository)
class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistRemoteDataSource remote;

  WatchlistRepositoryImpl(this.remote);

  @override
  Future<List<WatchlistMovie>> getWatchlistMovies() async {
    return remote.getMovies();
  }

  @override
  Future<List<WatchlistTv>> getWatchlistTv() async {
    return remote.getTv();
  }

  @override
  Future<void> addToWatchlist({
    required int mediaId,
    required String mediaType,
  }) {
    return remote.updateWatchlist(
      mediaId: mediaId,
      mediaType: mediaType,
      watchlist: true,
    );
  }

  @override
  Future<void> removeFromWatchlist({
    required int mediaId,
    required String mediaType,
  }) {
    return remote.updateWatchlist(
      mediaId: mediaId,
      mediaType: mediaType,
      watchlist: false,
    );
  }
}
