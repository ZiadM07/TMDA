import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/core/utils/enums.dart';
import 'package:tmda/features/shared/presentation/widgets/see_all_card.dart';

class SearchResultsList extends StatelessWidget {
  final List<dynamic> items;
  final SearchFilter filter;
  final VoidCallback onLoadMore;

  const SearchResultsList({
    super.key,
    required this.items,
    required this.filter,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    final uiItems = mapToUiItems(items, filter);



    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 300) {
          onLoadMore();
        }
        return false;
      },

      child: ListView.separated(
        key: PageStorageKey(filter),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        physics: const BouncingScrollPhysics(),
        itemCount: uiItems.length,
        itemBuilder: (context, index) {
          final item = uiItems[index];

          return SeeAllCard(
            key: ValueKey(item.id),
            item: SeeAllCardItem(
              id: item.id,
              title: item.title,
              rating: item.rating,
              year: item.year,
              language: item.language,
              voteCount: item.voteCount,
              imageUrl: item.imagePath != null
                  ? "${AppConstants.tmdaImagePath}${item.imagePath}"
                  : null,
            ),
          ).addAction(
            onTap: () => context.router.push(switch (filter) {
              SearchFilter.movies => MoviesDetailsRoute(movieId: item.id),
              SearchFilter.tv => TvDetailsRoute(tvId: item.id),
              SearchFilter.people => ActorDetailsRoute(personId: item.id),
            }),
          );
        },
      ),
    );
    
  
  }
}

List<SearchResultItem> mapToUiItems(List<dynamic> items, SearchFilter filter) {
  return items
      .map((item) {
        switch (filter) {
          case SearchFilter.movies:
            return SearchResultItem(
              id: item.id,
              title: item.title,
              rating: item.voteAverage,
              imagePath: item.posterPath,
              year: item.releaseDate.split('-').first,
              language: item.originalLanguage,
              voteCount: item.voteCount,
            );
          case SearchFilter.tv:
            return SearchResultItem(
              id: item.id,
              title: item.name,
              rating: item.voteAverage,
              imagePath: item.posterPath,
              year: item.firstAirDate.split('-').first,
              language: item.originalLanguage,
              voteCount: item.voteCount,
            );
          case SearchFilter.people:
            return SearchResultItem(
              id: item.id,
              title: item.name,
              rating: item.popularity,
              imagePath: item.profilePath,
            );
        }
      })
      .toList(growable: false);
}

class SearchResultItem {
  final int id;
  final String title;
  final double rating;
  final String? imagePath;
  final String? year;
  final String? language;
  final int? voteCount;

  const SearchResultItem({
    required this.id,
    required this.title,
    required this.rating,
    required this.imagePath,
    this.year,
    this.language,
    this.voteCount,
  });
}
