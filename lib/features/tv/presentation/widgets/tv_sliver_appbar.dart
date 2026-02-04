import 'package:carousel_slider/carousel_slider.dart';
import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/features/tv/domain/entities/tv_show.dart';
import '../../../../core/constants/exports.dart';
import '../../../shared/presentation/widgets/media_poster_card.dart';
import '../../../shared/presentation/widgets/page_indicators.dart';

class TvSliverAppbar extends StatefulWidget {
  final List<TvShow> tvShows;

  const TvSliverAppbar({super.key, required this.tvShows});

  @override
  State<TvSliverAppbar> createState() => _TvSliverAppbarState();
}

class _TvSliverAppbarState extends State<TvSliverAppbar> {
  final ValueNotifier<int> _indexNotifier = ValueNotifier(0);

  @override
  void dispose() {
    _indexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.tvShows.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    final cs = context.colorScheme;
    final heroCount = widget.tvShows.length.clamp(1, 4);

    return SliverAppBar(
      pinned: false,
      floating: false,
      snap: false,
      expandedHeight: 360,
      flexibleSpace: Stack(
        children: [
          // ================== CAROUSEL ==================
          CarouselSlider.builder(
            itemCount: heroCount,
            itemBuilder: (context, index, _) {
              final tv = widget.tvShows[index];

              return MediaPosterCard(
                imageUrl: '${AppConstants.tmdaImagePath}${tv.posterPath}',
                title: tv.name,
                rating: tv.voteAverage,
              ).addAction(
                onTap: () =>
                    context.pushRoute(TvDetailsRoute(tvId: tv.id)),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              height: 430,
              onPageChanged: (index, _) {
                _indexNotifier.value = index;
              },
            ),
          ),

          // ================== INDICATORS ==================
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: ValueListenableBuilder<int>(
              valueListenable: _indexNotifier,
              builder: (_, index, _) {
                return PageIndicators(
                  length: heroCount,
                  currentIndex: index,
                  colorScheme: cs,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
