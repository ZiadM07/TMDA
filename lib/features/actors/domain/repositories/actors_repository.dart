import 'package:tmda/features/actors/domain/entities/actor_details.dart';
import 'package:tmda/features/actors/domain/entities/actor_credit.dart';

abstract class ActorRepository {
  Future<ActorDetails> getActorDetails(int actorId);
  Future<List<ActorCredit>> getActorCredits(int actorId);
}
