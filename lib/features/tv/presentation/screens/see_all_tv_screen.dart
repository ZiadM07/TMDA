import 'package:tmda/features/watchlist/presentation/cubits/watchlist_cubit.dart';

import '../../../../config/router/app_router.gr.dart';
import '../../../../core/constants/exports.dart';
import '../../../../core/state/app_state.dart';
import '../../../../core/state/state_handler.dart';
import '../../../../core/utils/enums.dart';
import '../../../shared/presentation/widgets/app_loading.dart';
import '../../../shared/presentation/widgets/see_all_card.dart';
import '../cubits/see_all_tv_cubit.dart';

@RoutePage()
class SeeAllTvScreen extends StatefulWidget {
  final TvCategory category;
  final int? tvId;

  const SeeAllTvScreen({super.key, required this.category, this.tvId});

  @override
  State<SeeAllTvScreen> createState() => _SeeAllTvScreenState();
}

class _SeeAllTvScreenState extends State<SeeAllTvScreen> {
  late final ScrollController _controller;
  SeeAllTvCubit? _cubit;

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
        _cubit = getIt<SeeAllTvCubit>()
          ..loadInitial(widget.category, tvId: widget.tvId);
        return _cubit!;
      },
      child: AppScaffold(
        showBackButton: true,
        appbarSize: 56,
        title: _title(context),
        body: BlocBuilder<SeeAllTvCubit, AppState<SeeAllTvState>>(
          buildWhen: (p, c) => p.status != c.status,
          builder: (context, state) {
            return StateHandler(
              state: state,
              onRetry: () => context.read<SeeAllTvCubit>().loadInitial(
                widget.category,
                tvId: widget.tvId,
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

                    final tv = items[index];

                    return BlocSelector<WatchlistCubit, WatchlistState, bool>(
                      selector: (_) =>
                          context.read<WatchlistCubit>().isTvSaved(tv.id),
                      builder: (context, isSaved) {
                        final watchlistCubit = context.read<WatchlistCubit>();

                        return SeeAllCard(
                          key: ValueKey(tv.id),
                          item: SeeAllCardItem(
                            id: tv.id,
                            title: tv.name,
                            imageUrl:
                                "${AppConstants.tmdaImagePath}${tv.posterPath}",
                            rating: tv.voteAverage,
                            year: tv.firstAirDate.split('-').first,
                            language: tv.originalLanguage,
                            voteCount: tv.voteCount,
                            isSaved: isSaved,
                          ),
                          onTap: () {
                            context.router.push(TvDetailsRoute(tvId: tv.id));
                          },
                          onSaveTap: () {
                            watchlistCubit.toggleTv(
                              WatchlistTvInput(
                                id: tv.id,
                                name: tv.name,
                                posterPath: tv.posterPath,
                                voteAverage: tv.voteAverage,
                                voteCount: tv.voteCount,
                                firstAirDate: tv.firstAirDate,
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
      case TvCategory.airingToday:
        return context.locale.airingToday;
      case TvCategory.popular:
        return context.locale.popularShows;
      case TvCategory.topRated:
        return context.locale.topRatedShows;
      case TvCategory.recommended:
        return context.locale.recommended;
      case TvCategory.similar:
        return context.locale.similarTvShows;
    }
  }
}
