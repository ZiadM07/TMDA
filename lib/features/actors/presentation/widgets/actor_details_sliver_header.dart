import 'package:tmda/config/theme/app_color_scheme.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/actors/domain/entities/actor_details.dart';
import 'package:tmda/features/shared/presentation/widgets/app_image.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';

class ActorDetailsSliverHeader extends StatelessWidget {
  const ActorDetailsSliverHeader({super.key, required this.actor});
  final ActorDetails actor;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 380,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: ActorHeaderShadowPainter()),
            ),
            _ImageField(actor: actor),
            const _GradientField(),
            _NameField(actor: actor),
          ],
        ),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({required this.actor});

  final ActorDetails actor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      bottom: 20,
      right: 20,
      child: ClipPath(
        clipper: ActorHeaderClipper(),
        child: AppText(
          actor.name,
          maxLines: 2,
          style: context.textTheme.headlineLarge?.copyWith(
            color: context.colorScheme.textPrimary,
            fontWeight: FontWeight.w700,
            height: 1.1,
            shadows: const [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 8,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GradientField extends StatelessWidget {
  const _GradientField();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipPath(
        clipper: ActorHeaderClipper(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.5, 1.0],
              colors: [
                Colors.black.withValues(alpha: 0.2),
                Colors.transparent,
                Colors.black.withValues(alpha: 0.9),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ImageField extends StatelessWidget {
  const _ImageField({required this.actor});

  final ActorDetails actor;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ActorHeaderClipper(),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: AppImage(
          imageUrl: '${AppConstants.tmdaImagePath}${actor.profilePath}',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ActorHeaderShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = ActorHeaderClipper().getClip(size);

    // Create shadow effect
    final shadowPath = path.shift(const Offset(0, 8));

    canvas.drawShadow(
      shadowPath,
      Colors.black.withValues(alpha: 0.6),
      20,
      true,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ActorHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    final radius = 40.0; // Adjust this value for more/less rounding

    // Start from top-left
    path.lineTo(0, 0);

    // Draw along the top edge
    path.lineTo(size.width, 0);

    // Draw down the right edge until near the bottom (before the radius)
    path.lineTo(size.width, size.height - radius);

    // Create the rounded bottom-right corner
    path.quadraticBezierTo(
      size.width, // Control point X (right edge)
      size.height, // Control point Y (bottom edge)
      size.width - radius, // End point X (radius distance from right)
      size.height, // End point Y (bottom edge)
    );

    // Draw along the bottom edge to the left
    path.lineTo(0, size.height);

    // Draw up the left edge back to start
    path.lineTo(0, 0);

    // Close the path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant ActorHeaderClipper oldClipper) {
    return false;
  }
}
