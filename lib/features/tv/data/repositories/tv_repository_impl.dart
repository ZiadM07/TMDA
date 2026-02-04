import 'package:tmda/features/movies/domain/entities/cast_member.dart';
import 'package:tmda/features/tv/domain/entities/tv_video.dart';

import '../../../../core/constants/exports.dart';
import '../../domain/entities/paginated_tv.dart';
import '../../domain/entities/tv_details.dart';
import '../../domain/repositories/tv_repository.dart';
import '../data_sources/tv_remote_data_source.dart';

@LazySingleton(as: TvRepository)
class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource remote;

  TvRepositoryImpl(this.remote);

  @override
  Future<PaginatedTv> getAiringToday({int page = 1}) =>
      remote.getAiringToday(page);

  @override
  Future<PaginatedTv> getPopular({int page = 1}) =>
      remote.getPopular(page);

  @override
  Future<PaginatedTv> getTopRated({int page = 1}) =>
      remote.getTopRated(page);

  @override
  Future<TvDetails> getTvDetails(int tvId) =>
      remote.getDetails(tvId);

  @override
  Future<List<CastMember>> getTvCredits(int tvId) =>
      remote.getCredits(tvId);

  @override
  Future<PaginatedTv> getTvRecommendations(int tvId, {int page = 1}) =>
      remote.getRecommendations(tvId, page);

  @override
  Future<PaginatedTv> getTvSimilar(int tvId, {int page = 1}) =>
      remote.getSimilar(tvId, page);

  @override
  Future<List<TvVideo>> getTvTrailers(int tvId) =>
      remote.getTrailers(tvId);
}

