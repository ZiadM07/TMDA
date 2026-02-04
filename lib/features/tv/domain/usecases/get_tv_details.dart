import '../entities/tv_details.dart';
import '../repositories/tv_repository.dart';
import '../../../../core/constants/exports.dart';

@Injectable()
class GetTvDetails {
  final TvRepository repository;
  GetTvDetails(this.repository);

  Future<TvDetails> call(int tvId) {
    return repository.getTvDetails(tvId);
  }
}
