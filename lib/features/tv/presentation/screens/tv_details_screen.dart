import 'package:tmda/core/state/app_state.dart';
import 'package:tmda/core/state/state_handler.dart';
import 'package:tmda/features/tv/domain/entities/tv_details.dart';
import 'package:tmda/features/tv/presentation/cubits/tv_details_cubit.dart';
import 'package:tmda/features/tv/presentation/widgets/tv_details_sliver_body.dart';
import 'package:tmda/features/tv/presentation/widgets/tv_details_sliver_credits.dart';
import 'package:tmda/features/tv/presentation/widgets/tv_details_sliver_header.dart';
import 'package:tmda/features/tv/presentation/widgets/tv_details_sliver_recommended.dart';
import 'package:tmda/features/tv/presentation/widgets/tv_details_sliver_similar.dart';

import '../../../../core/constants/exports.dart';

@RoutePage()
class TvDetailsScreen extends StatelessWidget {
  final int tvId;

  const TvDetailsScreen({super.key, required this.tvId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TvDetailsCubit>()..loadTv(tvId),
      child: AppScaffold(
        appbarSize: 0,
        showBackButton: false,
        body: BlocBuilder<TvDetailsCubit, AppState<TvDetails>>(
          builder: (context, state) {
            return StateHandler(
              state: state,
              builder: (context, state) {
                final tv = state.data!;
                return CustomScrollView(
                  slivers: [
                    TvDetailsSliverHeader(tv: tv),
                    TvDetailsSliverBody(tv: tv),
                    const TvDetailsSliverCredits(),
                    const TvDetailsSliverRecommended(),
                    const TvDetailsSliverSimilar(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
