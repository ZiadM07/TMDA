import 'package:tmda/features/movies/data/models/cast_model.dart';
import 'package:tmda/features/tv/data/data_sources/tv_remote_data_source.dart';
import 'package:tmda/features/tv/data/models/tv_details_model.dart';
import 'package:tmda/features/tv/data/models/tv_video_model.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/constants/exports.dart';
import '../../domain/entities/paginated_tv.dart';
import '../../domain/entities/tv_details.dart';
import '../models/tv_show_model.dart';

@LazySingleton(as: TvRemoteDataSource)
class TvRemoteDataSourceImpl implements TvRemoteDataSource {
  final ApiClient api;

  TvRemoteDataSourceImpl(this.api);

  @override
  Future<PaginatedTv> getAiringToday(int page) async {
    final res = await api.getPaginated(ApiEndpoints.tvAiringToday, page: page);

    return _mapPaginated(res.data);
  }

  @override
  Future<PaginatedTv> getPopular(int page) async {
    final res = await api.getPaginated(ApiEndpoints.tvPopular, page: page);
    return _mapPaginated(res.data);
  }

  @override
  Future<PaginatedTv> getTopRated(int page) async {
    final res = await api.getPaginated(ApiEndpoints.tvTopRated, page: page);
    return _mapPaginated(res.data);
  }

  PaginatedTv _mapPaginated(Map<String, dynamic> json) {
    final results = (json['results'] as List)
        .map((e) => TvShowModel.fromJson(e).toEntity())
        .toList();

    return PaginatedTv(
      page: json['page'],
      totalPages: json['total_pages'],
      results: results,
    );
  }

  @override
  Future<TvDetails> getDetails(int tvId) async {
    final res = await api.get(ApiEndpoints.tvDetails(tvId));
    return TvDetailsModel.fromJson(res.data).toEntity();
  }

  @override
  Future<List<CastModel>> getCredits(int tvId) async {
    final res = await api.get(ApiEndpoints.tvCredits(tvId));
    return (res.data['cast'] as List<dynamic>? ?? [])
        .map((e) => CastModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PaginatedTv> getRecommendations(int tvId, int page) async {
    final res = await api.get(
      ApiEndpoints.tvRecommendations(tvId),
      query: {'page': page},
    );
    return _mapPaginated(res.data);
  }

  @override
  Future<PaginatedTv> getSimilar(int tvId, int page) async {
    final res = await api.get(
      ApiEndpoints.similarTvShows(tvId),
      query: {'page': page},
    );
    return _mapPaginated(res.data);
  }
  @override
  Future<List<TvVideoModel>> getTrailers(int tvId) async {
    final res = await api.get(ApiEndpoints.tvVideos(tvId));
    return (res.data['results'] as List<dynamic>? ?? [])
        .map((e) => TvVideoModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
