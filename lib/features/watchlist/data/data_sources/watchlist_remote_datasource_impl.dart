import 'package:tmda/core/constants/exports.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';

import '../models/watchlist_movie_model.dart';
import '../models/watchlist_tv_model.dart';
import 'watchlist_remote_datasource.dart';

@LazySingleton(as: WatchlistRemoteDataSource)
class WatchlistRemoteDataSourceImpl implements WatchlistRemoteDataSource {
  final ApiClient api;
  final AppPreferences prefs;

  WatchlistRemoteDataSourceImpl(this.api, this.prefs);

  @override
  Future<List<WatchlistMovieModel>> getMovies() async {
    final accountId = await prefs.getAccountId();

    final response = await api.get(ApiEndpoints.watchlistMovies(accountId));

    final List results = response.data['results'] ?? [];

    return results.map((e) => WatchlistMovieModel.fromJson(e)).toList();
  }

  @override
  Future<List<WatchlistTvModel>> getTv() async {
    final accountId = await prefs.getAccountId();

    final response = await api.get(ApiEndpoints.watchlistTv(accountId));

    final List results = response.data['results'] ?? [];

    return results.map((e) => WatchlistTvModel.fromJson(e)).toList();
  }

  @override
  Future<void> updateWatchlist({
    required int mediaId,
    required String mediaType,
    required bool watchlist,
  }) async {
    final accountId = await prefs.getAccountId();

    await api.post(
      ApiEndpoints.updateWatchlist(accountId),
      body: {
        'media_type': mediaType, // movie | tv
        'media_id': mediaId,
        'watchlist': watchlist,
      },
    );
  }
}
