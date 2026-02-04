import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/profile/data/data_sources/profile_remote_datasource.dart';

import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remote;

  ProfileRepositoryImpl(this.remote);

  @override
  Future<Profile> getProfile() {
    return remote.getProfile();
  }
}
