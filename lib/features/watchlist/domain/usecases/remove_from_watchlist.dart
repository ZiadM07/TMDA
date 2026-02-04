import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/watchlist/domain/repositories/watchlist_repository.dart';

@injectable
class RemoveFromWatchlist {
  final WatchlistRepository repo;

  RemoveFromWatchlist(this.repo);

  Future<void> call(int id, String type) {
    return repo.removeFromWatchlist(mediaId: id, mediaType: type);
  }
}
