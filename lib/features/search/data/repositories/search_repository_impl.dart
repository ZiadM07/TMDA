import '../../../../core/constants/exports.dart';
import '../../domain/entities/search_result.dart';
import '../../domain/repositories/search_repository.dart';
import '../data_sources/search_remote_data_source.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remote;

  SearchRepositoryImpl(this.remote);

  @override
  Future<SearchResult> search({
    required String query,
    int page = 1,
  }) async {
    final model = await remote.search(query: query, page: page);
    return model.toEntity();
  }
}
