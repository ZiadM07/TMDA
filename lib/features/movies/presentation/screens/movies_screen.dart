import 'package:tmda/core/state/state_handler.dart';

import '../../../../core/constants/exports.dart';
import '../../../../core/state/app_state.dart';
import '../../../shared/presentation/widgets/app_loading.dart';
import '../cubits/movies_overview_cubit.dart';
import '../widgets/movie_sliver_appbar_section.dart';
import '../widgets/now_playing_sliver_section.dart';
import '../widgets/popular_playing_sliver_section.dart';
import '../widgets/top_rated_sliver_section.dart';

@RoutePage()
class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MoviesOverviewCubit>()..loadOverview(),
      child: AppScaffold(
        appbarSize: 0,
        showBackButton: false,
        body: BlocBuilder<MoviesOverviewCubit, AppState<MoviesOverviewData>>(
          builder: (context, state) {
            return StateHandler(
              state: state,
              loadingWidget: Center(child: Loading.loader(context)),
              onRetry: () {
                context.read<MoviesOverviewCubit>().loadOverview();
              },
              builder: (context, state) {
                return _MoviesSuccessView(data: state.data!);
              },
            );
          },
        ),
      ),
    );
  }
}

class _MoviesSuccessView extends StatelessWidget {
  final MoviesOverviewData data;

  const _MoviesSuccessView({required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        MoviesSliverAppBar(movies: data.nowPlaying),
        NowPlayingSliverSection(movies: data.nowPlaying),
        PopularPlayingSliverSection(movies: data.popular),
        TopRatedSliverSection(movies: data.topRated),
      ],
    );
  }
}
