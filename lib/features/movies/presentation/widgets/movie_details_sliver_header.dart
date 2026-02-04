import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/movies/domain/entities/movie_details.dart';
import 'package:tmda/features/movies/presentation/cubits/movie_details_cubit.dart';
import 'package:tmda/features/shared/presentation/widgets/app_image.dart';
import 'package:tmda/features/shared/presentation/widgets/app_svg.dart';

class MovieDetailsSliverHeader extends StatelessWidget {
  final MovieDetails movie;
  const MovieDetailsSliverHeader({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 380,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: CustomPaint(painter: MovieHeaderShadowPainter()),
            ),
            ClipPath(
              clipper: MovieHeaderClipper(),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: AppImage(
                  imageUrl:
                      '${AppConstants.tmdaImagePath}${movie.backdropPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: ClipPath(
                clipper: MovieHeaderClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.85),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              left: MediaQuery.of(context).size.width / 2 - 25,

              child: SizedBox(
                height: 50,
                width: 50,
                child: AppSvg(Svgs.play).addAction(
                  onTap: () {
                    final cubit = context.read<MovieDetailsCubit>();
                    final trailer = cubit.trailers.first;
                    context.router.push(
                      TrailerRoute(
                        youtubeKey: trailer.key,
                        title: '${movie.title} ${context.locale.trailer}',
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieHeaderShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = MovieHeaderClipper().getClip(size);

    // Push shadow DOWN more
    final shadowPath = path.shift(const Offset(0, 18));

    canvas.drawShadow(
      shadowPath,
      Colors.black.withValues(alpha: 0.95), // MUCH darker
      40, // Bigger elevation = harder edge
      true,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class MovieHeaderClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, size.height * 0.0025000);
    path0.lineTo(0, size.height * 0.9200000);
    path0.quadraticBezierTo(
      size.width * 0.3781250,
      size.height * 1.0006250,
      size.width * 0.4975000,
      size.height * 0.9950000,
    );
    path0.quadraticBezierTo(
      size.width * 0.6275000,
      size.height * 1.0006250,
      size.width,
      size.height * 0.9200000,
    );
    path0.lineTo(size.width, 0);
    path0.close();
    return path0;
  }

  @override
  bool shouldReclip(covariant MovieHeaderClipper oldClipper) {
    return true;
  }
}
