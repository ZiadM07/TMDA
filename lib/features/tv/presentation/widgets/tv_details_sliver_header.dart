import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/shared/presentation/widgets/app_image.dart';
import 'package:tmda/features/shared/presentation/widgets/app_svg.dart';
import 'package:tmda/features/tv/domain/entities/tv_details.dart';
import 'package:tmda/features/tv/presentation/cubits/tv_details_cubit.dart';

class TvDetailsSliverHeader extends StatelessWidget {
  final TvDetails tv;
  const TvDetailsSliverHeader({super.key, required this.tv});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 380,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: CustomPaint(painter: TvHeaderShadowPainter()),
            ),
            ClipPath(
              clipper: TvHeaderClipper(),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: AppImage(
                  imageUrl: '${AppConstants.tmdaImagePath}${tv.backdropPath}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: ClipPath(
                clipper: TvHeaderClipper(),
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
              bottom: 15,
              left: MediaQuery.of(context).size.width / 2 - 25,

              child: SizedBox(
                height: 50,
                width: 50,
                child: AppSvg(Svgs.play).addAction(
                  onTap: () {
                    final cubit = context.read<TvDetailsCubit>();
                    final trailer = cubit.trailers.first;
                    context.router.push(
                      TrailerRoute(
                        youtubeKey: trailer.key,
                        title: '${tv.name} ${context.locale.trailer}',
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

class TvHeaderShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = TvHeaderClipper().getClip(size);

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

class TvHeaderClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, size.height * 0.0023810);
    path0.lineTo(0, size.height);
    path0.quadraticBezierTo(
      size.width * 0.1281389,
      size.height * 0.9059524,
      size.width * 0.2073056,
      size.height * 0.9023810,
    );
    path0.cubicTo(
      size.width * 0.2513889,
      size.height * 0.8815476,
      size.width * 0.7232778,
      size.height * 0.8845238,
      size.width * 0.7656389,
      size.height * 0.9038810,
    );
    path0.quadraticBezierTo(
      size.width * 0.8489722,
      size.height * 0.9038810,
      size.width,
      size.height * 0.9976190,
    );
    path0.lineTo(size.width, 0);
    path0.close();
    return path0;
  }

  @override
  bool shouldReclip(covariant TvHeaderClipper oldClipper) {
    return true;
  }
}
