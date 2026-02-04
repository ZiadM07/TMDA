import 'package:tmda/features/watchlist/presentation/cubits/watchlist_cubit.dart';

import '../../../../config/router/app_router.gr.dart';
import '../../../../core/constants/exports.dart';
import '../../../../core/state/app_state.dart';
import '../../../../core/state/state_handler.dart';
import '../../../../core/utils/enums.dart';
import '../../../shared/presentation/widgets/app_loading.dart';
import '../../../shared/presentation/widgets/see_all_card.dart';
import '../cubits/see_all_movies_cubit.dart';

@RoutePage()
class SeeAllMoviesScreen extends StatefulWidget {
  final MovieCategory category;
  final int? movieId;

  const SeeAllMoviesScreen({super.key, required this.category, this.movieId});

  @override
  State<SeeAllMoviesScreen> createState() => _SeeAllMoviesScreenState();
}

class _SeeAllMoviesScreenState extends State<SeeAllMoviesScreen> {
  late final ScrollController _controller;
  SeeAllMoviesCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    if (!_controller.hasClients || _cubit == null) return;

    final state = _cubit!.state;
    if (state.status == StateStatus.none) return;

    final max = _controller.position.maxScrollExtent;
    final current = _controller.position.pixels;

    if (current >= max * 0.8) {
      _cubit!.loadMore();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _cubit = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        _cubit = getIt<SeeAllMoviesCubit>()
          ..loadInitial(widget.category, movieId: widget.movieId);
        return _cubit!;
      },
      child: AppScaffold(
        title: _title(context),
        body: BlocBuilder<SeeAllMoviesCubit, AppState<SeeAllMoviesState>>(
          buildWhen: (p, c) => p.status != c.status,
          builder: (context, state) {
            return StateHandler(
              state: state,
              onRetry: () => context.read<SeeAllMoviesCubit>().loadInitial(
                widget.category,
                movieId: widget.movieId,
              ),
              loadingOverlayWidget: Center(child: Loading.loader(context)),
              builder: (context, state) {
                final items = state.data!.items;

                return ListView.separated(
                  controller: _controller,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 100,
                  ),
                  itemCount: items.length + 1,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    if (index >= items.length) {
                      return Center(child: Loading.loader(context));
                    }

                    final movie = items[index];

                    return BlocSelector<WatchlistCubit, WatchlistState, bool>(
                      selector: (_) =>
                          context.read<WatchlistCubit>().isMovieSaved(movie.id),
                      builder: (context, isSaved) {
                        final watchlistCubit = context.read<WatchlistCubit>();

                        return SeeAllCard(
                          key: ValueKey(movie.id),
                          item: SeeAllCardItem(
                            id: movie.id,
                            title: movie.title,
                            imageUrl:
                                "${AppConstants.tmdaImagePath}${movie.posterPath}",
                            rating: movie.voteAverage,
                            year: movie.releaseDate?.split('-').first,
                            language: movie.originalLanguage,
                            voteCount: movie.voteCount,
                            isSaved: isSaved,
                          ),
                          onTap: () {
                            context.router.push(
                              MoviesDetailsRoute(movieId: movie.id),
                            );
                          },
                          onSaveTap: () {
                            watchlistCubit.toggleMovie(
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
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _title(BuildContext context) {
    switch (widget.category) {
      case MovieCategory.nowPlaying:
        return context.locale.nowPlaying;
      case MovieCategory.popular:
        return context.locale.popularMovies;
      case MovieCategory.topRated:
        return context.locale.topRatedMovies;
      case MovieCategory.recommended:
        return context.locale.recommended;
      case MovieCategory.similar:
        return context.locale.similarMovies;
    }
  }
}
