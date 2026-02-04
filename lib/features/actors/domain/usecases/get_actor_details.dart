import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/actors/domain/entities/actor_details.dart';
import 'package:tmda/features/actors/domain/repositories/actors_repository.dart';

@Injectable()
class GetActorDetails {
  final ActorRepository repository;

  GetActorDetails(this.repository);

  Future<ActorDetails> call(int actorId) {
    return repository.getActorDetails(actorId);
  }
}
