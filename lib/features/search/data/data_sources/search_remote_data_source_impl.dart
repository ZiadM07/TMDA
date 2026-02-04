import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_endpoints.dart';
import '../../../../core/constants/exports.dart';

import '../models/search_result_model.dart';
import 'search_remote_data_source.dart';

@LazySingleton(as: SearchRemoteDataSource)
class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiClient api;

  SearchRemoteDataSourceImpl(this.api);

  @override
  Future<SearchResultModel> search({
    required String query,
    int page = 1,
  }) async {
    final res = await api.get(
      ApiEndpoints.searchMulti,
      query: {
        'query': query,
        'page': page,
      },
    );

    return SearchResultModel.fromJson(res.data);
  }
}
