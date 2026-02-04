import 'dart:ui';

import '../../../../core/constants/exports.dart';
import '../../../../core/utils/app_padding.dart';
import 'app_text.dart';
import 'app_widget_direction.dart';

class AppScaffold extends StatefulWidget {
  final Widget body;
  final Widget? appbarChild;
  final Widget? action;
  final String? title;
  final double appbarSize;
  final Color? backgroundColor;
  final void Function()? onBackPress;
  final bool showBackButton;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final bool resizeToAvoidBottomInset;
  final bool useGlowBackground; // New parameter

  const AppScaffold({
    super.key,
    required this.body,
    this.title,
    this.appbarSize = 70.0,
    this.appbarChild,
    this.action,
    this.backgroundColor,
    this.onBackPress,
    this.showBackButton = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation =
        FloatingActionButtonLocation.startDocked,
    this.resizeToAvoidBottomInset = true,
    this.useGlowBackground = true, // Default to true
  });

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = true;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final offset = _scrollController.offset;

    if (offset > _lastOffset && offset > 10) {
      // scrolling down
      if (_showAppBar) setState(() => _showAppBar = false);
    } else if (offset < _lastOffset) {
      // scrolling up
      if (!_showAppBar) setState(() => _showAppBar = true);
    }

    _lastOffset = offset;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.colorScheme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: widget.useGlowBackground
          ? Colors.transparent
          : (widget.backgroundColor ?? context.colorScheme.surface),
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      extendBodyBehindAppBar: widget.useGlowBackground,
      appBar: widget.appbarSize > 0
          ? PreferredSize(
              preferredSize: Size(double.infinity, widget.appbarSize),
              child: AnimatedSlide(
                offset: _showAppBar ? Offset.zero : const Offset(0, -1),
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: AnimatedOpacity(
                  opacity: _showAppBar ? 1 : 0,
                  duration: const Duration(milliseconds: 150),
                  child: Container(
                    color: widget.useGlowBackground
                        ? Colors.transparent
                        : (widget.backgroundColor ??
                              context.colorScheme.surface),
                    alignment: Alignment.center,
                    child: SafeArea(
                      child: Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (widget.showBackButton)
                                AppWidgetDirection(
                                  child:
                                      Icon(
                                        SolarIconsOutline.altArrowLeft,
                                        size: 26.0,
                                        color: context.colorScheme.onSurface,
                                      ).addAction(
                                        padding: AppPadding.set(
                                          horizontal: 12.0,
                                        ),
                                        onBounce:
                                            widget.onBackPress ??
                                            () =>
                                                AutoRouterX(context).maybePop(),
                                      ),
                                ),
                              AppText(
                                widget.title ?? "",
                                size: 18,
                                color: context.colorScheme.onSurface,
                                weight: FontWeight.w600,
                              ).addPadding(start: 12.0),
                            ],
                          ),
                          if (widget.action != null) widget.action!,
                        ],
                      ).addPadding(top: 12.0),
                    ),
                  ),
                ),
              ),
            )
          : null,

      body: widget.useGlowBackground
          ? AppGlowBackground(
              isDark: isDark,
              child: PrimaryScrollController(
                controller: _scrollController,
                child: widget.body,
              ),
            )
          : PrimaryScrollController(
              controller: _scrollController,
              child: widget.body,
            ),

      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }
}

/// Modern glow background with 3 strategic positioned glows
class AppGlowBackground extends StatelessWidget {
  final Widget child;
  final bool isDark;

  const AppGlowBackground({super.key, required this.child, this.isDark = true});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return Stack(
      children: [
        // Base background color
        Container(color: cs.surface),

        // Glow 1: Top Left - Cyan (Primary color)
        Positioned(
          top: 110,
          left: 50,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: 70,
              sigmaY: 70,
              tileMode: TileMode.decal,
            ),
            child: Container(
              width: 120,
              height: 100,
              decoration: BoxDecoration(
                color: cs.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),

        // Glow 2: Middle Right - Pink (Secondary color)
        Positioned(
          right: 50,
          bottom: 380,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: 100,
              sigmaY: 100,
              tileMode: TileMode.decal,
            ),
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: cs.secondary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),

        // Glow 3: Bottom Left - Mix of Primary and Secondary
        Positioned(
          bottom: 90,
          left: 30,
          child: ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: 70,
              sigmaY: 70,
              tileMode: TileMode.decal,
            ),
            child: Container(
              width: 120,
              height: 100,
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.8),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),

        // Content on top
        child,
      ],
    );
  }
}
