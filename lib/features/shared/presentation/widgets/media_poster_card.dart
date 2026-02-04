import '../../../../config/theme/app_color_scheme.dart';
import '../../../../core/constants/exports.dart';
import 'app_image.dart';
import 'app_rating_bar.dart';
import 'app_text.dart';

class MediaPosterCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double rating;
  final String? heroTag;

  const MediaPosterCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.rating,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;

    return SizedBox(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Image layer
          RepaintBoundary(
            child: heroTag != null
                ? Hero(tag: heroTag!, child: _buildImage(context))
                : _buildImage(context),
          ),

          // Gradient overlay
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Color(0xCC000000)],
              ),
            ),
          ),

          // Content
          Positioned(
            left: 20,
            right: 20,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  color: colorScheme.textPrimary,
                  size: 24,
                  weight: FontWeight.w600,
                ),
                const SizedBox(height: 6),
                AppRatingBar(rating: rating / 2, size: 18),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 12),
                    const SizedBox(width: 4),
                    AppText(
                      rating.toStringAsFixed(1),
                      size: 12,
                      weight: FontWeight.w500,
                      color: colorScheme.textPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return AppImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      borderRadius: 0,
      memCacheWidth: MediaQuery.sizeOf(context).width.toInt(),
    );
  }
}
