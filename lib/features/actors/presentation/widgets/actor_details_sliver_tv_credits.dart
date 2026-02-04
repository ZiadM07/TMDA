import 'package:tmda/core/constants/exports.dart';

import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/features/actors/presentation/cubits/actor_cubit.dart';
import 'package:tmda/features/shared/presentation/widgets/media_tile_card.dart';
import '../../../shared/presentation/widgets/app_text.dart';

class ActorDetailsSliverTvCredits extends StatelessWidget {
  const ActorDetailsSliverTvCredits({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ActorDetailsCubit>();
    final tvShows = cubit.tvCredits;

    if (tvShows.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Column(
        children: [
          _Header(),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: tvShows.length.clamp(0, 10),
              itemBuilder: (context, index) {
                final tvShow = tvShows[index];

                return MediaTileCard(
                  key: ValueKey(tvShow.id),
                  item: MediaCardItem(
                    id: tvShow.id,
                    title: tvShow.title,
                    rating: tvShow.rating,
                    imageUrl:
                        "${AppConstants.tmdaImagePath}${tvShow.posterPath}",
                  ),
                ).addAction(
                  padding: const EdgeInsets.only(top: 10, right: 15),
                  onTap: () =>
                      context.pushRoute(TvDetailsRoute(tvId: tvShow.id)),
                );
              },
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

// ===============================
// HEADER
// ===============================
class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
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
        AppText(context.locale.tvShows, style: context.textTheme.titleLarge),
      ],
    ).addPadding(horizontal: 20);
  }
}
