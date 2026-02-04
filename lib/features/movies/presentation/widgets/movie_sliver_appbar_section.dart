import 'package:carousel_slider/carousel_slider.dart';
import 'package:tmda/config/router/app_router.gr.dart';
import '../../../../core/constants/exports.dart';
import '../../../../features/movies/domain/entities/movie.dart';
import '../../../shared/presentation/widgets/media_poster_card.dart';
import '../../../shared/presentation/widgets/page_indicators.dart';

class MoviesSliverAppBar extends StatefulWidget {
  final List<Movie> movies;

  const MoviesSliverAppBar({super.key, required this.movies});

  @override
  State<MoviesSliverAppBar> createState() => _MoviesSliverAppBarState();
}

class _MoviesSliverAppBarState extends State<MoviesSliverAppBar> {
  final ValueNotifier<int> _indexNotifier = ValueNotifier(0);

  @override
  void dispose() {
    _indexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    final cs = context.colorScheme;
    final heroCount = widget.movies.length.clamp(1, 4);

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
              final movie = widget.movies[index];

              return MediaPosterCard(
                imageUrl:
                    '${AppConstants.tmdaImagePath}${movie.backdropPath ?? movie.posterPath ?? ''}',
                title: movie.title,
                rating: movie.voteAverage,
              ).addAction(
                onTap: () =>
                    context.pushRoute(MoviesDetailsRoute(movieId: movie.id)),
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
