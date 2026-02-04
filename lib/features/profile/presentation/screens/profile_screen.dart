import 'package:tmda/core/state/app_state.dart';
import 'package:tmda/core/state/state_handler.dart';
import 'package:tmda/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:tmda/features/profile/domain/entities/profile.dart';
import 'package:tmda/features/profile/presentation/cubits/profile_cubit.dart';
import 'package:tmda/features/profile/presentation/widgets/profile_header.dart';
import 'package:tmda/features/profile/presentation/widgets/watchlist_movies_section.dart';
import 'package:tmda/features/profile/presentation/widgets/watchlist_tv_section.dart';

import '../../../../core/constants/exports.dart';

@RoutePage()
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ProfileCubit>()..loadProfile()),
        BlocProvider(create: (context) => getIt<AuthCubit>()),
      ],
      child: AppScaffold(
        showBackButton: false,
        appbarSize: 0,
        body: BlocBuilder<ProfileCubit, AppState<Profile>>(
          builder: (context, state) {
            return StateHandler(
              state: state,
              builder: (context, state) {
                final profile = state.data!;

                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: ProfileHeader(profile: profile)),
                    SliverToBoxAdapter(child: const WatchlistMoviesSection()),
                    SliverToBoxAdapter(child: const WatchlistTvSection()),
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
