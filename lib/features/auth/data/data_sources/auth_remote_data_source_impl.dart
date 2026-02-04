import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/constants/exports.dart';
import '../models/request_token_model.dart';
import '../models/session_model.dart';
import 'auth_remote_data_source.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<RequestTokenModel> createRequestToken() async {
    final response = await client.get(ApiEndpoints.createRequestToken);

    return RequestTokenModel.fromJson(response.data);
  }

  @override
  Future<RequestTokenModel> validateWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final response = await client.post(
      ApiEndpoints.validateWithLogin,
      body: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
    );

    return RequestTokenModel.fromJson(response.data);
  }

  @override
  Future<SessionModel> createSession(String requestToken) async {
    final response = await client.post(
      ApiEndpoints.createSession,
      body: {'request_token': requestToken},
    );

    return SessionModel.fromJson(response.data);
  }
}
