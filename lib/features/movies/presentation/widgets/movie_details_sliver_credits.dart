import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/movies/presentation/cubits/movie_details_cubit.dart';
import 'package:tmda/features/shared/presentation/widgets/app_divider.dart';
import 'package:tmda/features/shared/presentation/widgets/media_tile_card.dart';
import '../../../shared/presentation/widgets/app_text.dart';

class MovieDetailsSliverCredits extends StatelessWidget {
  const MovieDetailsSliverCredits({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MovieDetailsCubit>();
    final credits = cubit.credits;

    if (credits.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Column(
        children: [
          const _Header(),
          const SizedBox(height: 10),
          SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: credits.length.clamp(0, 10),
              itemBuilder: (context, index) {
                final cast = credits[index];

                return MediaTileCard(
                  key: ValueKey(cast.id),
                  item: MediaCardItem(
                    id: cast.id,
                    title: cast.name,
                    imageUrl:
                        "${AppConstants.tmdaImagePath}${cast.profilePath}",
                  ),
                ).addAction(
                  onTap: () =>
                      context.pushRoute(ActorDetailsRoute(personId: cast.id)),
                  padding: const EdgeInsets.only(top: 10, right: 15),
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
        AppText(context.locale.cast, style: context.textTheme.titleLarge),
      ],
    ).addPadding(horizontal: 20);
  }
}
