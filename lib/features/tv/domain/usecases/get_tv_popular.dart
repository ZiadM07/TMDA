import '../entities/paginated_tv.dart';
import '../repositories/tv_repository.dart';
import '../../../../core/constants/exports.dart';

@Injectable()
class GetTvPopular {
  final TvRepository repository;
  GetTvPopular(this.repository);

  Future<PaginatedTv> call({int page = 1}) {
    return repository.getPopular(page: page);
  }
}
