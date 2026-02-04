import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/core/utils/enums.dart';
import 'package:tmda/features/movies/presentation/cubits/movie_details_cubit.dart';
import 'package:tmda/features/shared/presentation/widgets/media_tile_card.dart';
import '../../../shared/presentation/widgets/app_text.dart';

class MovieDetailsSliverSimilar extends StatelessWidget {
  const MovieDetailsSliverSimilar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MovieDetailsCubit>();
    final movies = cubit.similar;

    if (movies.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Column(
        children: [
          _Header(movieId: cubit.state.data?.id ?? 0),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: movies.length.clamp(0, 10),
              itemBuilder: (context, index) {
                final movie = movies[index];

                return MediaTileCard(
                  key: ValueKey(movie.id),
                  item: MediaCardItem(
                    id: movie.id,
                    title: movie.title,
                    rating: movie.voteAverage,
                    imageUrl:
                        "${AppConstants.tmdaImagePath}${movie.posterPath}",
                  ),
                ).addAction(
                  padding: const EdgeInsets.only(top: 10, right: 15),
                  onTap: () =>
                      context.pushRoute(MoviesDetailsRoute(movieId: movie.id)),
                );
              },
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

// ===============================
// HEADER
// ===============================
class _Header extends StatelessWidget {
  final int movieId;
  const _Header({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Row(
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
          context.locale.similarMovies,
          style: context.textTheme.titleLarge,
        ),
        const Spacer(),
        Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              context.pushRoute(
                SeeAllMoviesRoute(
                  category: MovieCategory.similar,
                  movieId: movieId,
                ),
              );
            },
            child: AppText(
              context.locale.seeAll,
              size: 13,
              weight: FontWeight.w500,
              color: context.colorScheme.primary.withValues(alpha: 0.6),
            ).addPadding(horizontal: 8, vertical: 4),
          ),
        ),
      ],
    ).addPadding(horizontal: 20);
  }
}
