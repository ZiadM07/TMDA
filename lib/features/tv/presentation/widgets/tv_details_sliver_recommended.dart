import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/core/utils/enums.dart';
import 'package:tmda/features/shared/presentation/widgets/app_divider.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';
import 'package:tmda/features/shared/presentation/widgets/media_tile_card.dart';
import 'package:tmda/features/tv/presentation/cubits/tv_details_cubit.dart';

class TvDetailsSliverRecommended extends StatelessWidget {
  const TvDetailsSliverRecommended({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<TvDetailsCubit>();
    final tvShowRecommended = cubit.recommended;

    if (tvShowRecommended.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Column(
        children: [
          _Header(tvId: cubit.state.data?.id ?? 0),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: tvShowRecommended.length.clamp(0, 10),
              itemBuilder: (context, index) {
                final tv = tvShowRecommended[index];

                return MediaTileCard(
                  key: ValueKey(tv.id),
                  item: MediaCardItem(
                    id: tv.id,
                    title: tv.name,
                    rating: tv.voteAverage,
                    imageUrl: "${AppConstants.tmdaImagePath}${tv.posterPath}",
                  ),
                ).addAction(
                  padding: const EdgeInsets.only(top: 10, right: 15),
                  onTap: () => context.pushRoute(TvDetailsRoute(tvId: tv.id)),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          const AppDivider(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

// ===============================
// HEADER
// ===============================
class _Header extends StatelessWidget {
  final int tvId;
  const _Header({required this.tvId});

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
        AppText(
          context.locale.recommended,
          style: context.textTheme.titleLarge,
        ),
        const Spacer(),
        Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () {
              context.pushRoute(
                SeeAllTvRoute(category: TvCategory.recommended, tvId: tvId),
              );
            },
            child: AppText(
              context.locale.seeAll,
              size: 13,
              weight: FontWeight.w500,
              color: context.colorScheme.primary.withValues(alpha: 0.6),
            ).addPadding(horizontal: 8, vertical: 4),
          ),
        ),
      ],
    ).addPadding(horizontal: 20);
  }
}
