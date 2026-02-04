import 'dart:math';

import '../../../../core/constants/exports.dart';
import 'app_image.dart';
import 'app_text.dart';

class MediaTileCard extends StatelessWidget {
  final MediaCardItem item;
  final ValueChanged<int>? onTap;

  static const double _rotation = 2 * pi / 180; // 2 degrees
  static const double _radius = 32.0;
  static const double _width = 200.0;
  static const double _height = 300.0;

  const MediaTileCard({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      height: _height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: onTap != null ? () => onTap!(item.id) : null,
          child: Transform.rotate(
            angle: _rotation,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_radius),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Image layer - most expensive part
                  _CardImage(imageUrl: item.imageUrl),

                  // Gradient overlay - const for performance
                  const _CardGradient(),

                  // Text content
                  _CardContent(title: item.title, rating: item.rating),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  final String imageUrl;

  const _CardImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AppImage(imageUrl: imageUrl, fit: BoxFit.cover);
  }
}

class _CardGradient extends StatelessWidget {
  const _CardGradient();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Color(0xCC000000)],
          stops: [0.5, 1.0], // Gradient starts halfway down
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final String title;
  final double? rating;

  const _CardContent({required this.title, required this.rating});

  @override
  Widget build(BuildContext context) {
    final hasRating = rating != null && rating! > 0;

    return Positioned(
      left: 16,
      right: 16,
      bottom: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              height: 1.3, // Better line spacing
            ),
          ),
          if (hasRating) ...[
            const SizedBox(height: 6),
            _RatingDisplay(rating: rating!),
          ],
        ],
      ),
    );
  }
}

class _RatingDisplay extends StatelessWidget {
  final double rating;

  const _RatingDisplay({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          context.locale.tmdaScore,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.onSurface.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(width: 2),
        AppText(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: Colors.amber,
          ),
        ),
        const SizedBox(width: 2),
        const Icon(Icons.star_rate_rounded, size: 12, color: Colors.amber),
      ],
    );
  }
}

@immutable
class MediaCardItem {
  final int id;
  final String imageUrl;
  final String title;
  final double? rating;

  const MediaCardItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    this.rating,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaCardItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          imageUrl == other.imageUrl &&
          title == other.title &&
          rating == other.rating;

  @override
  int get hashCode =>
      id.hashCode ^ imageUrl.hashCode ^ title.hashCode ^ rating.hashCode;
}
