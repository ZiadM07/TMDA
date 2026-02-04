import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/config/theme/app_color_scheme.dart';
import 'package:tmda/core/utils/number_formatter.dart';
import 'package:tmda/features/shared/presentation/widgets/app_advanced_text.dart';
import 'package:tmda/features/shared/presentation/widgets/app_divider.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';
import 'package:tmda/features/watchlist/presentation/cubits/watchlist_cubit.dart';
import '../../domain/entities/tv_details.dart';

class TvDetailsSliverBody extends StatelessWidget {
  final TvDetails tv;
  const TvDetailsSliverBody({super.key, required this.tv});

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
                    "${tv.voteAverage.toStringAsFixed(1)} / 10",
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    "${NumberFormatter.compact(tv.voteCount)} ${context.locale.votes.toLowerCase()}",
                    style: context.textTheme.bodyMedium,
                    color: context.colorScheme.textSecondary,
                  ),
                ],
              ),
              BlocSelector<WatchlistCubit, WatchlistState, bool>(
                selector: (_) =>
                    context.read<WatchlistCubit>().isTvSaved(tv.id),

                builder: (context, isSaved) {
                  final cubit = context.read<WatchlistCubit>();

                  return Column(
                    children: [
                      Icon(
                        isSaved
                            ? SolarIconsBold.bookmark
                            : SolarIconsOutline.bookmark,
                        color: isSaved
                            ? context.colorScheme.primary
                            : context.colorScheme.textSecondary,
                        size: 28,
                      ).addAction(onTap: () => cubit.toggleTv(WatchlistTvInput(
                        id: tv.id,
                        name: tv.name,
                        posterPath: tv.posterPath,
                        
                        voteAverage: tv.voteAverage,
                        voteCount: tv.voteCount,
                        firstAirDate: tv.firstAirDate,
                      ))),
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
              AppText(tv.name, style: context.textTheme.titleLarge),
              const SizedBox(height: 10),
              AppText(
                tv.genres.map((g) => g.name).join(' / '),
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
                    tv.firstAirDate.split('-')[0],
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
                    '${tv.numberOfEpisodes} ${context.locale.episodes}',
                    style: context.textTheme.titleMedium,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  AppText(
                    context.locale.seasons,
                    style: context.textTheme.titleMedium,
                  ),
                  AppText(
                    '${tv.numberOfSeasons} ${context.locale.seasons.toLowerCase()}',
                    style: context.textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          AppAdvancedText(
            tv.overview,
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
