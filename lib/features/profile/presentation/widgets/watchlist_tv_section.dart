import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';
import 'package:tmda/features/shared/presentation/widgets/empty_state.dart';
import 'package:tmda/features/shared/presentation/widgets/media_tile_card.dart';
import 'package:tmda/features/watchlist/presentation/cubits/watchlist_cubit.dart';

class WatchlistTvSection extends StatelessWidget {
  const WatchlistTvSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WatchlistCubit, WatchlistState>(
      buildWhen: (p, c) => p.version != c.version,
      builder: (context, state) {
        final cubit = context.read<WatchlistCubit>();
        final tvShows = cubit.tvShows;

        if (!cubit.isReady) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            if (tvShows.isEmpty)
              EmptyState(
                title: context.locale.watchlistTvShows,
                description: context.locale.addShowsToWatchlist,
              ),

            if (tvShows.isNotEmpty)
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
                        context.locale.watchlistTvShows,
                        style: context.textTheme.titleLarge,
                      ),
                      Spacer(),
                      Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          onTap: () =>
                              context.router.push(const TvWatchlistRoute()),
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
                      itemCount: tvShows.length,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final show = tvShows[index];
                        return MediaTileCard(
                          item: MediaCardItem(
                            id: show.id,
                            imageUrl:
                                "${AppConstants.tmdaImagePath}${show.posterPath}",
                            title: show.name,
                            rating: show.voteAverage,
                          ),
                        ).addAction(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 15,
                          ),
                          onTap: () =>
                              context.pushRoute(TvDetailsRoute(tvId: show.id)),
                        );
                      },
                    ),
                  ),
                ],
              ).addPadding(top: 20, bottom: 100),
          ],
        );
      },
    );
  }
}
