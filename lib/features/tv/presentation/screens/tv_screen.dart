import '../../../../core/constants/exports.dart';

import 'package:tmda/core/state/state_handler.dart';

import '../../../../core/state/app_state.dart';
import '../../../shared/presentation/widgets/app_loading.dart';
import '../cubits/tv_overview_cubit.dart';
import '../widgets/airing_today_sliver_section.dart';
import '../widgets/popular_tv_sliver_section.dart';
import '../widgets/top_rated_tv_sliver_section.dart';
import '../widgets/tv_sliver_appbar.dart';

@RoutePage()
class TvScreen extends StatelessWidget {
  const TvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TvOverviewCubit>()..loadOverview(),
      child: AppScaffold(
        appbarSize: 0,
        showBackButton: false,
        body: BlocBuilder<TvOverviewCubit, AppState<TvOverviewData>>(
          builder: (context, state) {
            return StateHandler(
              state: state,
              loadingWidget: Center(child: Loading.loader(context)),
              onRetry: () {
                context.read<TvOverviewCubit>().loadOverview();
              },
              builder: (context, state) {
                return _TvSuccessView(data: state.data!);
              },
            );
          },
        ),
      ),
    );
  }
}

class _TvSuccessView extends StatelessWidget {
  final TvOverviewData data;

  const _TvSuccessView({required this.data});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        TvSliverAppbar(tvShows: data.airingToday),
        AiringTodaySliverSection(tvShows: data.airingToday),
        PopularTvSliverSection(tvShows: data.popular),
        TopRatedTvSliverSection(tvShows: data.topRated),
      ],
    );
  }
}
