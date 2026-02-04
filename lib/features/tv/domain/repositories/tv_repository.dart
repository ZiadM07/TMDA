import 'package:tmda/features/movies/domain/entities/cast_member.dart';
import 'package:tmda/features/tv/domain/entities/tv_video.dart';

import '../entities/paginated_tv.dart';
import '../entities/tv_details.dart';

abstract class TvRepository {
  Future<PaginatedTv> getAiringToday({int page = 1});
  Future<PaginatedTv> getPopular({int page = 1});
  Future<PaginatedTv> getTopRated({int page = 1});

  Future<TvDetails> getTvDetails(int tvId);
  Future<List<CastMember>> getTvCredits(int tvId);
  Future<PaginatedTv> getTvRecommendations(int tvId, {int page = 1});
  Future<PaginatedTv> getTvSimilar(int tvId, {int page = 1});
  Future<List<TvVideo>> getTvTrailers(int tvId);
}
