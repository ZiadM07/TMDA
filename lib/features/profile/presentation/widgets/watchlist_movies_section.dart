import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';
import 'package:tmda/features/shared/presentation/widgets/empty_state.dart';
import 'package:tmda/features/shared/presentation/widgets/media_tile_card.dart';

import 'package:tmda/features/watchlist/presentation/cubits/watchlist_cubit.dart';

class WatchlistMoviesSection extends StatelessWidget {
  const WatchlistMoviesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistCubit, WatchlistState>(
      buildWhen: (p, c) => p.version != c.version,
      builder: (context, state) {
        final cubit = context.read<WatchlistCubit>();
        final movies = cubit.movies;

        if (!cubit.isReady) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            if (movies.isEmpty)
              EmptyState(
                title: context.locale.watchlistMovies,
                description: context.locale.addMoviesToWatchlist,
              ),

            if (movies.isNotEmpty)
              Column(
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
                        context.locale.watchlistMovies,
                        style: context.textTheme.titleLarge,
                      ),
                      Spacer(),
                      Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () =>
                              context.router.push(const MoviesWatchlistRoute()),
                          borderRadius: BorderRadius.circular(8),
                          child: AppText(
                            context.locale.seeAll,
                            size: 13,
                            weight: FontWeight.w500,
                            color: context.colorScheme.primary.withValues(
                              alpha: 0.6,
                            ),
                          ).addPadding(horizontal: 8, vertical: 4),
                        ),
                      ),
                    ],
                  ).addPadding(horizontal: 20),

                  const SizedBox(height: 10),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      itemCount: movies.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
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
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 15,
                          ),
                          onTap: () => context.pushRoute(
                            MoviesDetailsRoute(movieId: movie.id),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ).addPadding(top: 20),
          ],
        );
      },
    );
  }
}
