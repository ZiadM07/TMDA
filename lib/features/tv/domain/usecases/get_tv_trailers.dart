import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/tv/domain/entities/tv_video.dart';
import 'package:tmda/features/tv/domain/repositories/tv_repository.dart';

@Injectable()
class GetTvTrailers {
  final TvRepository repository;

  GetTvTrailers(this.repository);

  Future<List<TvVideo>> call(int tvId) {
    return repository.getTvTrailers(tvId);
  }
}
