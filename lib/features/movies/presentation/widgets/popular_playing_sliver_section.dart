import '../../../../config/router/app_router.gr.dart';
import '../../../../core/constants/exports.dart';
import '../../../../core/utils/enums.dart';
import '../../../shared/presentation/widgets/app_text.dart';
import '../../../shared/presentation/widgets/media_tile_card.dart';
import '../../domain/entities/movie.dart';

class PopularPlayingSliverSection extends StatelessWidget {
  final List<Movie> movies;

  const PopularPlayingSliverSection({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 25,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 15),
              AppText(
                context.locale.popularMovies,
                style: context.textTheme.titleLarge,
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  context.router.push(
                    SeeAllMoviesRoute(category: MovieCategory.popular),
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: AppText(
                  context.locale.seeAll,
                  size: 13,
                  weight: FontWeight.w500,
                  color: context.colorScheme.primary.withValues(alpha: 0.6),
                ).addPadding(horizontal: 8, vertical: 4),
              ),
            ],
          ).addPadding(horizontal: 20),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return MediaTileCard(
                  item: MediaCardItem(
                    id: movie.id,
                    imageUrl:
                        "${AppConstants.tmdaImagePath}${movie.posterPath}",
                    title: movie.title,
                    rating: movie.voteAverage,
                  ),
                ).addAction(
                  padding: EdgeInsetsGeometry.only(
                    top: 10,
                    left: 10,
                    right: 15,
                  ),
                  onTap: () =>
                      context.pushRoute(MoviesDetailsRoute(movieId: movie.id)),
                );
              },
            ),
          ),
        ],
      ).addPadding(top: 20),
    );
  }
}
