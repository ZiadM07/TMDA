import '../entities/paginated_tv.dart';
import '../repositories/tv_repository.dart';
import '../../../../core/constants/exports.dart';

@Injectable()
class GetTvTopRated {
  final TvRepository repository;
  GetTvTopRated(this.repository);

  Future<PaginatedTv> call({int page = 1}) {
    return repository.getTopRated(page: page);
  }
}
