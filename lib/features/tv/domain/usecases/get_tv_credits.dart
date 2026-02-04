import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/movies/domain/entities/cast_member.dart';
import 'package:tmda/features/tv/domain/repositories/tv_repository.dart';

@injectable
class GetTvCredits {
  final TvRepository repository;

  GetTvCredits(this.repository);

  Future<List<CastMember>> call(int tvId) {
    return repository.getTvCredits(tvId);
  }
}
