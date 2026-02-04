import 'package:tmda/config/theme/app_color_scheme.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';

import '../../../../core/constants/exports.dart';

class SearchEmptyState extends StatefulWidget {
  const SearchEmptyState({super.key});

  @override
  State<SearchEmptyState> createState() => _SearchEmptyStateState();
}

class _SearchEmptyStateState extends State<SearchEmptyState>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon with gradient background
                  Icon(
                    SolarIconsOutline.magnifier,
                    size: 60,
                    color: context.colorScheme.primary.withValues(alpha: 0.7),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  AppText(
                    context.locale.whatYouWantToWatch,
                    align: TextAlign.center,
                    style: context.textTheme.headlineSmall?.copyWith(
                      height: 1.2,
                      fontWeight: FontWeight.w700,
                      color: context.colorScheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Subtitle
                  AppText(
                    context.locale.findYourFavoriteMoviesTvShowsAndActors,
                    align: TextAlign.center,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.textSecondary,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ).addPadding(horizontal: 20);
  }
}
