import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../../../core/constants/exports.dart';
import 'package:shimmer/shimmer.dart';

class AppImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double borderRadius;
  final int? memCacheWidth;
  final Function()? onLoaded;

  const AppImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.borderRadius = 0,
    this.memCacheWidth,
    this.onLoaded,
  });

  @override
  State<AppImage> createState() => _AppImageState();
}

class _AppImageState extends State<AppImage> {
  bool _hasCalledOnLoaded = false;

  @override
  void didUpdateWidget(AppImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset the flag if the image URL changes
    if (oldWidget.imageUrl != widget.imageUrl) {
      _hasCalledOnLoaded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final adjustedWidth =
              (constraints.maxWidth.isFinite
                      ? constraints.maxWidth
                      : widget.width)
                  ?.toInt();
          return CachedNetworkImage(
            imageUrl: widget.imageUrl,
            cacheKey: CustomCacheManager.getCacheKey(widget.imageUrl),
            cacheManager: CustomCacheManager.instance,
            memCacheWidth: widget.memCacheWidth ?? adjustedWidth,
            width: widget.width,
            height: widget.height,
            fit: widget.fit ?? BoxFit.cover,
            progressIndicatorBuilder: (context, url, progress) {
              // Check if image is fully loaded
              if (progress.progress != null && progress.progress == 1.0) {
                if (!_hasCalledOnLoaded && widget.onLoaded != null) {
                  _hasCalledOnLoaded = true;
                  // Call after build completes
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    widget.onLoaded?.call();
                  });
                }
              }

              // Show shimmer loading indicator
              return Shimmer.fromColors(
                baseColor: context.isDarkTheme
                    ? AppColors.baseShimmerDark
                    : AppColors.baseShimmerLight,
                highlightColor: context.isDarkTheme
                    ? AppColors.highlightShimmerDark
                    : AppColors.highlightShimmerLight,
                child: Container(
                  width: widget.width ?? double.infinity,
                  height: widget.height ?? double.infinity,
                  color: Colors.white,
                ),
              );
            },
            errorWidget: (context, url, error) {
              return AspectRatio(
                aspectRatio: 1,
                child: Image.asset(Pngs.empty, fit: BoxFit.cover),
              );
            },
          );
        },
      ),
    );
  }
}

class GlamImageProvider extends CachedNetworkImageProvider {
  GlamImageProvider(
    super.url, {
    super.maxHeight,
    super.maxWidth,
    super.scale = 1.0,
    super.errorListener,
    super.headers,
    super.imageRenderMethodForWeb,
  }) : super(
         cacheKey: CustomCacheManager.getCacheKey(url),
         cacheManager: CustomCacheManager.instance,
       );
}

class CustomCacheManager {
  static final instance = CacheManager(
    Config(
      AppConstants.cacheFolder,
      stalePeriod: const Duration(days: AppConstants.imagesCacheDuration),
    ),
  );

  static String getCacheKey(String url) {
    Uri uri = Uri.parse(url);
    String path = uri.path;
    return 'https://${uri.host}$path';
  }
}
