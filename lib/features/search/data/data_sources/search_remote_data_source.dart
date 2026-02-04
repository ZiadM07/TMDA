import '../models/search_result_model.dart';

abstract class SearchRemoteDataSource {
  Future<SearchResultModel> search({
    required String query,
    int page,
  });
}
