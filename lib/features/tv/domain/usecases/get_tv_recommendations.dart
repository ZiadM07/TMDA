import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/tv/domain/repositories/tv_repository.dart';
import 'package:tmda/features/tv/domain/entities/paginated_tv.dart';

@injectable
class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<PaginatedTv> call(int tvId, {int page = 1}) {
    return repository.getTvRecommendations(tvId, page: page);
  }
}
