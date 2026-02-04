import 'package:tmda/core/api/api_client.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/profile/data/data_sources/profile_remote_datasource.dart';
import 'package:tmda/features/profile/data/models/profile_model.dart';

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient api;

  ProfileRemoteDataSourceImpl(this.api);

  @override
  Future<ProfileModel> getProfile() async {
    final response = await api.get('/account');
    return ProfileModel.fromJson(response.data);
  }
}
