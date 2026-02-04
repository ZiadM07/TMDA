import 'package:tmda/features/movies/domain/entities/cast_member.dart';
import 'package:tmda/features/tv/domain/entities/tv_video.dart';

import '../../domain/entities/paginated_tv.dart';
import '../../domain/entities/tv_details.dart';

abstract class TvRemoteDataSource {
  Future<PaginatedTv> getAiringToday(int page);
  Future<PaginatedTv> getPopular(int page);
  Future<PaginatedTv> getTopRated(int page);

  Future<TvDetails> getDetails(int tvId);
    Future<List<CastMember>> getCredits(int tvId);
  Future<PaginatedTv> getRecommendations(int tvId, int page);
  Future<PaginatedTv> getSimilar(int tvId, int page);
  Future<List<TvVideo>> getTrailers(int tvId);
}
