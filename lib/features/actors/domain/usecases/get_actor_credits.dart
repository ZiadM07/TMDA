import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/actors/domain/entities/actor_credit.dart';
import 'package:tmda/features/actors/domain/repositories/actors_repository.dart';

@Injectable()
class GetActorCredits {
  final ActorRepository repository;

  GetActorCredits(this.repository);

  Future<List<ActorCredit>> call(int actorId) {
    return repository.getActorCredits(actorId);
  }
}
