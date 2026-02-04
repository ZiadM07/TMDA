import '../entities/paginated_tv.dart';
import '../repositories/tv_repository.dart';
import '../../../../core/constants/exports.dart';

@Injectable()
class GetAiringToday {
  final TvRepository repository;
  GetAiringToday(this.repository);

  Future<PaginatedTv> call({int page = 1}) {
    return repository.getAiringToday(page: page);
  }
}
