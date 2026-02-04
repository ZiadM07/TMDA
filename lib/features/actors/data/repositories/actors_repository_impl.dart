import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/actors/data/data_sources/actor_remote_data_source.dart';
import 'package:tmda/features/actors/data/models/actor_credit_model.dart';
import 'package:tmda/features/actors/data/models/actor_details_model.dart';
import 'package:tmda/features/actors/domain/entities/actor_credit.dart';
import 'package:tmda/features/actors/domain/entities/actor_details.dart';
import 'package:tmda/features/actors/domain/repositories/actors_repository.dart';

@LazySingleton(as: ActorRepository)
class ActorRepositoryImpl implements ActorRepository {
  final ActorRemoteDataSource remote;

  ActorRepositoryImpl(this.remote);

  @override
  Future<ActorDetails> getActorDetails(int actorId) async {
    final json = await remote.getActorDetails(actorId);
    return ActorDetailsModel.fromJson(json);
  }

  @override
  Future<List<ActorCredit>> getActorCredits(int actorId) async {
    final json = await remote.getActorCredits(actorId);

    final List cast = json['cast'] ?? [];

    return cast
        .where((e) => e['media_type'] == 'movie' || e['media_type'] == 'tv')
        .map((e) => ActorCreditModel.fromJson(e))
        .toList();
  }
}
