import 'package:tmda/core/constants/exports.dart';

import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/features/actors/presentation/cubits/actor_cubit.dart';
import 'package:tmda/features/shared/presentation/widgets/app_divider.dart';
import 'package:tmda/features/shared/presentation/widgets/media_tile_card.dart';
import '../../../shared/presentation/widgets/app_text.dart';

class ActorDetailsSliverMovieCredits extends StatelessWidget {
  const ActorDetailsSliverMovieCredits({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ActorDetailsCubit>();
    final movies = cubit.movieCredits;

    if (movies.isEmpty) {
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
              itemCount: movies.length.clamp(0, 10),
              itemBuilder: (context, index) {
                final movie = movies[index];

                return MediaTileCard(
                  key: ValueKey(movie.id),
                  item: MediaCardItem(
                    id: movie.id,
                    title: movie.title,
                    rating: movie.rating,
                    imageUrl:
                        "${AppConstants.tmdaImagePath}${movie.posterPath}",
                  ),
                ).addAction(
                  padding: const EdgeInsets.only(top: 10, right: 15),
                  onTap: () =>
                      context.pushRoute(MoviesDetailsRoute(movieId: movie.id)),
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
        AppText(context.locale.movies, style: context.textTheme.titleLarge),
      ],
    ).addPadding(horizontal: 20);
  }
}
