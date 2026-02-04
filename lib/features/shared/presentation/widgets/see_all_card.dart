import 'dart:math';
import 'package:tmda/features/shared/presentation/widgets/save_button.dart';

import '../../../../config/theme/app_color_scheme.dart';
import '../../../../core/constants/exports.dart';
import 'app_image.dart';
import 'app_text.dart';

class SeeAllCard extends StatelessWidget {
  final SeeAllCardItem item;
  final VoidCallback? onTap;
  final VoidCallback? onSaveTap;
  final bool enabled;

  const SeeAllCard({
    super.key,
    required this.item,
    this.onTap,
    this.onSaveTap,
    this.enabled = true,
  });

  static const double _rotation = 1.5 * pi / 180;
  static const double _cardHeight = 240.0;
  static const double _posterWidth = 140.0;
  static const double _posterHeight = 220.0;
  static const double _posterRadius = 32.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return RepaintBoundary(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(42),
        child: Stack(
          children: [
            // Background
            Transform.rotate(
              angle: _rotation,
              child: Container(
                height: _cardHeight,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.surface.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(42),
                ),
              ),
            ),

            // Poster image
            Positioned(
              top: 12,
              left: 16,
              child: Transform.rotate(
                angle: _rotation,
                child: _PosterImage(imageUrl: item.imageUrl),
              ),
            ),

            // Content area
            Positioned(top: 80, right: 20, child: _ContentArea(item: item)),

            // Save button
            if (item.isSaved != null)
              Positioned(
                top: 16,
                right: 16,
                child: SaveButton(
                  isSaved: item.isSaved!,
                  enabled: enabled,
                  colorScheme: colorScheme,
                  onTap: onSaveTap,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Optimized poster image with proper caching
class _PosterImage extends StatelessWidget {
  final String? imageUrl;

  const _PosterImage({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(SeeAllCard._posterRadius),
      child: SizedBox(
        width: SeeAllCard._posterWidth,
        height: SeeAllCard._posterHeight,
        child: AppImage(imageUrl: imageUrl ?? Pngs.empty, fit: BoxFit.cover),
      ),
    );
  }
}

class _ContentArea extends StatelessWidget {
  final SeeAllCardItem item;

  const _ContentArea({required this.item});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final metaText = _buildMetadata();

    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,

        mainAxisSize: MainAxisSize.min,
        children: [
          
          AppText(
            item.title,
            overflow: TextOverflow.ellipsis,
            align: TextAlign.center,
            size: 14,
            weight: FontWeight.w600,
            color: colorScheme.textPrimary,
          ),
          if (metaText != null) ...[
            const SizedBox(height: 10),
            AppText(
              metaText,
              align: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              size: 13,
              weight: FontWeight.w400,
              color: colorScheme.textSecondary,
            ),
          ],
          const SizedBox(height: 10),
          _RatingRow(
            rating: item.rating,
            voteCount: item.voteCount,
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }

  String? _buildMetadata() {
    final parts = <String>[
      if (item.year != null && item.year!.isNotEmpty) item.year!,
      if (item.genre != null && item.genre!.isNotEmpty) item.genre!,
      if (item.language != null && item.language!.isNotEmpty) item.language!,
    ];
    return parts.isEmpty ? null : parts.join(' • ');
  }
}

/// Extracted rating row for better performance
class _RatingRow extends StatelessWidget {
  final double rating;
  final int? voteCount;
  final ColorScheme colorScheme;

  const _RatingRow({
    required this.rating,
    required this.voteCount,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.star_rate_rounded, size: 16, color: Colors.amber),
        const SizedBox(width: 4),
        AppText(
          rating.toStringAsFixed(1),
          size: 14,
          weight: FontWeight.w400,
          color: colorScheme.textSecondary,
        ),
        if (voteCount != null && voteCount! > 0) ...[
          const SizedBox(width: 10),
          Flexible(
            child: AppText(
              '${_formatVoteCount(voteCount!)} ${context.locale.votes.toLowerCase()}',
              align: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              size: 14,
              weight: FontWeight.w400,
              color: colorScheme.textSecondary,
            ),
          ),
        ],
      ],
    );
  }

  String _formatVoteCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}

@immutable
class SeeAllCardItem {
  final int id;
  final String title;
  final String? imageUrl;
  final double rating;
  final int? voteCount;
  final String? year;
  final String? genre;
  final String? language;
  final bool? isSaved;

  const SeeAllCardItem({
    required this.id,
    required this.title,
    required this.rating,
    this.imageUrl,
    this.voteCount,
    this.year,
    this.genre,
    this.language,
    this.isSaved,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeeAllCardItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          imageUrl == other.imageUrl &&
          rating == other.rating &&
          voteCount == other.voteCount &&
          year == other.year &&
          genre == other.genre &&
          language == other.language &&
          isSaved == other.isSaved;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      imageUrl.hashCode ^
      rating.hashCode ^
      voteCount.hashCode ^
      year.hashCode ^
      genre.hashCode ^
      language.hashCode ^
      isSaved.hashCode;

  SeeAllCardItem copyWith({
    int? id,
    String? title,
    String? imageUrl,
    double? rating,
    int? voteCount,
    String? year,
    String? genre,
    String? language,
    bool? isSaved,
  }) {
    return SeeAllCardItem(
      id: id ?? this.id,
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      voteCount: voteCount ?? this.voteCount,
      year: year ?? this.year,
      genre: genre ?? this.genre,
      language: language ?? this.language,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
