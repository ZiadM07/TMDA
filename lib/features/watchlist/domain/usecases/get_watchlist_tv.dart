import 'package:tmda/features/watchlist/domain/entities/watchlist_tv.dart';
import 'package:tmda/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:tmda/core/constants/exports.dart';

@injectable
class GetWatchlistTv {
  final WatchlistRepository repo;

  GetWatchlistTv(this.repo);

  Future<List<WatchlistTv>> call() {
    return repo.getWatchlistTv();
  }
}
