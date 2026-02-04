import '../entities/search_result.dart';

abstract class SearchRepository {
  Future<SearchResult> search({required String query, int page = 1});
}
