import 'package:tmda/features/tv/domain/entities/tv_show.dart';

import '../../../../config/router/app_router.gr.dart';
import '../../../../core/constants/exports.dart';
import '../../../../core/utils/enums.dart';
import '../../../shared/presentation/widgets/app_text.dart';
import '../../../shared/presentation/widgets/media_tile_card.dart';

class TopRatedTvSliverSection extends StatelessWidget {
  final List<TvShow> tvShows;

  const TopRatedTvSliverSection({super.key, required this.tvShows});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
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
                context.locale.topRatedShows,
                style: context.textTheme.titleLarge,
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  context.router.push(
                    SeeAllTvRoute(category: TvCategory.topRated),
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: AppText(
                  context.locale.seeAll,
                  size: 13,
                  weight: FontWeight.w500,
                  color: context.colorScheme.primary.withValues(alpha: 0.6),
                ).addPadding(horizontal: 8, vertical: 4),
              ),
            ],
          ).addPadding(horizontal: 20),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: 6,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final tv = tvShows[index];
                return MediaTileCard(
                  key: ValueKey(tv.id),
                  item: MediaCardItem(
                    id: tv.id,
                    imageUrl: "${AppConstants.tmdaImagePath}${tv.posterPath}",
                    title: tv.name,
                    rating: tv.voteAverage,
                  ),
                ).addAction(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 15),
                  onTap: () => context.pushRoute(TvDetailsRoute(tvId: tv.id)),
                );
              },
            ),
          ),
        ],
      ).addPadding(top: 20, bottom: 100),
    );
  }
}
