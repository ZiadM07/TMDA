import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/core/state/app_state.dart';
import 'package:tmda/core/state/state_handler.dart';
import 'package:tmda/features/actors/domain/entities/actor_details.dart';
import 'package:tmda/features/actors/presentation/cubits/actor_cubit.dart';
import 'package:tmda/features/actors/presentation/widgets/actor_details_sliver_body.dart';
import 'package:tmda/features/actors/presentation/widgets/actor_details_sliver_header.dart';
import 'package:tmda/features/actors/presentation/widgets/actor_details_sliver_movie_credits.dart';
import 'package:tmda/features/actors/presentation/widgets/actor_details_sliver_tv_credits.dart';

@RoutePage()
class ActorDetailsScreen extends StatelessWidget {
  final int personId;

  const ActorDetailsScreen({super.key, required this.personId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ActorDetailsCubit>()..loadActor(personId),
      child: AppScaffold(
        appbarSize: 0,
        showBackButton: false,
        body: BlocBuilder<ActorDetailsCubit, AppState<ActorDetails>>(
          builder: (context, state) {
            return StateHandler(
              state: state,
              builder: (context, state) {
                final actor = state.data!;

                return CustomScrollView(
                  slivers: [
                    ActorDetailsSliverHeader(actor: actor),
                    ActorDetailsSliverBody(actor: actor),
                    const ActorDetailsSliverMovieCredits(),
                    const ActorDetailsSliverTvCredits(),
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
