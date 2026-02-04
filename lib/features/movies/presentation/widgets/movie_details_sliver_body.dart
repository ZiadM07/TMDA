import 'package:tmda/config/theme/app_color_scheme.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/core/utils/number_formatter.dart';
import 'package:tmda/features/shared/presentation/widgets/app_advanced_text.dart';
import 'package:tmda/features/shared/presentation/widgets/app_divider.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';
import 'package:tmda/features/shared/presentation/widgets/save_button.dart';
import 'package:tmda/features/watchlist/presentation/cubits/watchlist_cubit.dart';
import '../../domain/entities/movie_details.dart';

class MovieDetailsSliverBody extends StatelessWidget {
  final MovieDetails movie;
  const MovieDetailsSliverBody({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Icon(
                    SolarIconsBold.start1,
                    color: Colors.amber,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    "${movie.voteAverage.toStringAsFixed(1)} / 10",
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    "${NumberFormatter.compact(movie.voteCount)} ${context.locale.votes.toLowerCase()}",
                    style: context.textTheme.bodyMedium,
                    color: context.colorScheme.textSecondary,
                  ),
                ],
              ),
              BlocSelector<WatchlistCubit, WatchlistState, bool>(
                selector: (_) =>
                    context.read<WatchlistCubit>().isMovieSaved(movie.id),

                builder: (context, isSaved) {
                  final cubit = context.read<WatchlistCubit>();

                  return Column(
                    children: [
                      SaveButton(
                        size: 28,
                        key: ValueKey(movie.id),
                        isSaved: isSaved,
                        enabled: true,
                        colorScheme: context.colorScheme,
                        onTap: () => cubit.toggleMovie(
                          WatchlistMovieInput(
                            id: movie.id,
                            title: movie.title,
                            posterPath: movie.posterPath,
                            voteAverage: movie.voteAverage,
                            voteCount: movie.voteCount,
                            releaseDate: movie.releaseDate,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppText(
                        isSaved ? context.locale.saved : context.locale.save,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: isSaved
                              ? context.colorScheme.primary
                              : context.colorScheme.textSecondary,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ).addPadding(horizontal: 20.0),
          const SizedBox(height: 24),
          const AppDivider(),
          const SizedBox(height: 24),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText(movie.title, style: context.textTheme.titleLarge),
              const SizedBox(height: 10),
              AppText(
                movie.genres.map((g) => g.name).join(' / '),
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  AppText(
                    context.locale.year,
                    style: context.textTheme.titleMedium,
                  ),
                  AppText(
                    movie.releaseDate.split('-')[0],
                    style: context.textTheme.titleMedium,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  AppText(
                    context.locale.country,
                    style: context.textTheme.titleMedium,
                  ),
                  AppText(
                    movie.originalLanguage.toUpperCase(),
                    style: context.textTheme.titleMedium,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  AppText(
                    context.locale.length,
                    style: context.textTheme.titleMedium,
                  ),
                  AppText(
                    '${movie.runtime} ${context.locale.minutes}',
                    style: context.textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          AppAdvancedText(
            movie.overview ?? '',
            textStyle: context.textTheme.bodyMedium,
            lessText: context.locale.readLess,
            moreText: context.locale.readMore,
            align: TextAlign.center,
          ).addPadding(horizontal: 25.0),
          const SizedBox(height: 24),
          const AppDivider(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
