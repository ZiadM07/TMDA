import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/shared/presentation/widgets/empty_state.dart';
import 'package:tmda/features/shared/presentation/widgets/see_all_card.dart';
import 'package:tmda/features/watchlist/presentation/cubits/watchlist_cubit.dart';
import 'package:tmda/features/watchlist/presentation/widgets/dismissible_widget.dart';
import 'package:tmda/features/watchlist/presentation/widgets/swipe_instruction_banner.dart';

@RoutePage()
class MoviesWatchlistScreen extends StatelessWidget {
  const MoviesWatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: context.locale.watchlistMovies,
      body: BlocBuilder<WatchlistCubit, WatchlistState>(
        buildWhen: (p, c) => p.version != c.version,
        builder: (context, state) {
          final cubit = context.read<WatchlistCubit>();
          final movies = cubit.movies;

          if (movies.isEmpty) {
            return Center(
              child: EmptyState(
                title: context.locale.watchlistMovies,
                description: context.locale.addMoviesToWatchlist,
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
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return DismissibleWidget(
                    dismissibleKey: ValueKey(movie.id),
                    onDismissed: () {
                      cubit.toggleMovie(
                        WatchlistMovieInput(
                          id: movie.id,
                          title: movie.title,
                          posterPath: movie.posterPath,
                          voteAverage: movie.voteAverage,
                          voteCount: movie.voteCount,
                          releaseDate: movie.releaseDate,
                        ),
                      );
                    },
                    color: context.colorScheme.error,
                    child:
                        SeeAllCard(
                          item: SeeAllCardItem(
                            id: movie.id,
                            title: movie.title,
                            rating: movie.voteAverage,
                            year: movie.releaseDate.split('-').first,
                            voteCount: movie.voteCount,
                            imageUrl:
                                "${AppConstants.tmdaImagePath}${movie.posterPath}",
                          ),
                        ).addAction(
                          onTap: () => context.router.push(
                            MoviesDetailsRoute(movieId: movie.id),
                          ),
                        ),
                  );
                },
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 30)),
            ],
          );
        },
      ),
    );
  }
}
