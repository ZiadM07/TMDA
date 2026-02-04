import '../entities/search_result.dart';
import '../repositories/search_repository.dart';
import '../../../../core/constants/exports.dart';

@Injectable()
class SearchUsecase {
  final SearchRepository _repository;

  SearchUsecase(this._repository);

  Future<SearchResult> call({required String query, int page = 1}) {
    return _repository.search(query: query, page: page);
  }
}
