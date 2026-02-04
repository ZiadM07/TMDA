abstract class ActorRemoteDataSource {
  Future<Map<String, dynamic>> getActorDetails(int actorId);
  Future<Map<String, dynamic>> getActorCredits(int actorId);
}
