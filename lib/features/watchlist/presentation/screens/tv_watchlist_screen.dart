import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/shared/presentation/widgets/empty_state.dart';
import 'package:tmda/features/shared/presentation/widgets/see_all_card.dart';
import 'package:tmda/features/watchlist/presentation/cubits/watchlist_cubit.dart';
import 'package:tmda/features/watchlist/presentation/widgets/dismissible_widget.dart';
import 'package:tmda/features/watchlist/presentation/widgets/swipe_instruction_banner.dart';

@RoutePage()
class TvWatchlistScreen extends StatelessWidget {
  const TvWatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: context.locale.watchlistTvShows,
      body: BlocBuilder<WatchlistCubit, WatchlistState>(
        buildWhen: (p, c) => p.version != c.version,
        builder: (context, state) {
          final cubit = context.read<WatchlistCubit>();
          final tvShows = cubit.tvShows;

          if (!cubit.isReady) {
            return const SizedBox.shrink();
          }

          if (tvShows.isEmpty) {
            return Center(
              child: EmptyState(
                title: context.locale.watchlistTvShows,
                description: context.locale.addShowsToWatchlist,
              ),
            );
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: const SizedBox(height: 100)),
              SliverToBoxAdapter(
                child: SwipeInstructionBanner(
                  message: context.locale.swipeRightToRemove,
                ),
              ),
              SliverList.builder(
                itemCount: tvShows.length,
                itemBuilder: (context, index) {
                  final show = tvShows[index];

                  return DismissibleWidget(
                    dismissibleKey: ValueKey(show.id),
                    onDismissed: () {
                      cubit.toggleTv(
                        WatchlistTvInput(
                          id: show.id,
                          name: show.name,
                          posterPath: show.posterPath,
                          voteAverage: show.voteAverage,
                          voteCount: show.voteCount,
                          firstAirDate: show.firstAirDate,
                        ),
                      );
                    },
                    color: context.colorScheme.error,
                    child:
                        SeeAllCard(
                          item: SeeAllCardItem(
                            id: show.id,
                            title: show.name,
                            rating: show.voteAverage,
                            year: show.firstAirDate.split('-').first,
                            voteCount: show.voteCount,
                            imageUrl:
                                "${AppConstants.tmdaImagePath}${show.posterPath}",
                          ),
                        ).addAction(
                          onTap: () => context.router.push(
                            TvDetailsRoute(tvId: show.id),
                          ),
                        ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
