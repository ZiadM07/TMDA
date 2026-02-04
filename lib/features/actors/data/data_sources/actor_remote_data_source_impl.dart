import 'package:tmda/core/api/api_client.dart';
import 'package:tmda/core/api/api_endpoints.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/actors/data/data_sources/actor_remote_data_source.dart';

@LazySingleton(as: ActorRemoteDataSource)
class ActorRemoteDataSourceImpl implements ActorRemoteDataSource {
  final ApiClient api;

  ActorRemoteDataSourceImpl(this.api);

  @override
  Future<Map<String, dynamic>> getActorDetails(int actorId) async {
    final response = await api.get(ApiEndpoints.personDetails(actorId));
    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> getActorCredits(int actorId) async {
    final response = await api.get(ApiEndpoints.personCombinedCredits(actorId));
    return response.data as Map<String, dynamic>;
  }
}
