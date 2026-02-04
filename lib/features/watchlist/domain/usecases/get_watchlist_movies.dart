import 'package:tmda/features/watchlist/domain/entities/watchlist_movie.dart';
import 'package:tmda/features/watchlist/domain/repositories/watchlist_repository.dart';
import 'package:tmda/core/constants/exports.dart';

@injectable
class GetWatchlistMovies {
  final WatchlistRepository repo;

  GetWatchlistMovies(this.repo);

  Future<List<WatchlistMovie>> call() {
    return repo.getWatchlistMovies();
  }
}
