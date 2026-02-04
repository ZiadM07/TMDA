import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/tv/domain/repositories/tv_repository.dart';
import 'package:tmda/features/tv/domain/entities/paginated_tv.dart';
@injectable
class GetTvSimilar {
  final TvRepository repository;

  GetTvSimilar(this.repository);

  Future<PaginatedTv> call(int tvId, {int page = 1}) {
    return repository.getTvSimilar(tvId, page: page);
  }
}
