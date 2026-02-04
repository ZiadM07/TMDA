/// Generic paged response model for TMDb API
/// Used to parse paginated responses from the API
class PagedResponse<T> {
  final int page;
  final List<T> results;
  final int totalPages;
  final int totalResults;

  PagedResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PagedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PagedResponse(
      page: json['page'] as int? ?? 1,
      results:
          (json['results'] as List<dynamic>?)
              ?.map((item) => fromJsonT(item as Map<String, dynamic>))
              .toList() ??
          [],
      totalPages: json['total_pages'] as int? ?? 0,
      totalResults: json['total_results'] as int? ?? 0,
    );
  }
}
