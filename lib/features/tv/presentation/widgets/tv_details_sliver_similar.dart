import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/shared/presentation/widgets/media_tile_card.dart';
import 'package:tmda/features/tv/presentation/cubits/tv_details_cubit.dart';
import '../../../shared/presentation/widgets/app_text.dart';
import 'package:tmda/core/utils/enums.dart';

class TvDetailsSliverSimilar extends StatelessWidget {
  const TvDetailsSliverSimilar({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<TvDetailsCubit>();
    final tvShows = cubit.similar;

    if (tvShows.isEmpty) {
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
              itemCount: tvShows.length.clamp(0, 10),
              itemBuilder: (context, index) {
                final tvShow = tvShows[index];

                return MediaTileCard(
                  key: ValueKey(tvShow.id),
                  item: MediaCardItem(
                    id: tvShow.id,
                    title: tvShow.name,
                    rating: tvShow.voteAverage,
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
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

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
          context.locale.similarTvShows,
          style: context.textTheme.titleLarge,
        ),
        const Spacer(),
        Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () => context.pushRoute(
              SeeAllTvRoute(category: TvCategory.similar, tvId: tvId),
            ),
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
