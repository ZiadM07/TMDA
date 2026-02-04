import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/watchlist/domain/repositories/watchlist_repository.dart';

@injectable
class AddToWatchlist {
  final WatchlistRepository repo;

  AddToWatchlist(this.repo);

  Future<void> call(int id, String type) {
    return repo.addToWatchlist(mediaId: id, mediaType: type);
  }
}
