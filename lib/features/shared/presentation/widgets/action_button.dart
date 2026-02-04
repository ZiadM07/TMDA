import 'dart:ui';

import '../../../../core/constants/exports.dart';
import 'app_text.dart';

enum AppButtonType { primary, primaryGradient, danger, custom }

class ActionButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String title;
  final String loadingTitle;
  final AppButtonType type;
  final IconData? icon;
  final double? borderRadius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  // Enhanced control properties
  final Color? backgroundColor;
  final Color? textColor;
  final Gradient? gradient;
  final List<BoxShadow>? customShadows;
  final Border? border;
  final double? borderWidth;
  final Color? borderColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? iconSize;
  final double? iconSpacing;
  final bool enableGlassEffect;
  final double glassBlur;
  final bool enablePressAnimation;
  final double pressScale;
  final MainAxisAlignment? alignment;

  const ActionButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
    required this.title,
    this.loadingTitle = 'Loading...',
    this.type = AppButtonType.primary,
    this.icon,
    this.borderRadius,
    this.width,
    this.height,
    this.padding,

    // Enhanced properties
    this.backgroundColor,
    this.textColor,
    this.gradient,
    this.customShadows,
    this.border,
    this.borderWidth,
    this.borderColor,
    this.fontSize,
    this.fontWeight,
    this.iconSize,
    this.iconSpacing,
    this.enableGlassEffect = true,
    this.glassBlur = 8.0,
    this.enablePressAnimation = true,
    this.pressScale = 0.96,
    this.alignment,
  });

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.pressScale,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ------------------------------------------
  // BUTTON COLORS & STYLES (with custom override)
  // ------------------------------------------

  Color _getBackgroundColor(ColorScheme cs) {
    if (widget.backgroundColor != null) return widget.backgroundColor!;

    switch (widget.type) {
      case AppButtonType.primaryGradient:
        return cs.surfaceContainerHigh;
      case AppButtonType.danger:
        return cs.error;
      case AppButtonType.custom:
        return cs.surfaceContainerHigh;
      case AppButtonType.primary:
        return cs.primary;
    }
  }

  Color _getTextColor(ColorScheme cs) {
    if (widget.textColor != null) return widget.textColor!;

    switch (widget.type) {
      case AppButtonType.primaryGradient:
      case AppButtonType.danger:
      case AppButtonType.primary:
      case AppButtonType.custom:
        return cs.onPrimary;
    }
  }

  Gradient? _getGradient(ColorScheme cs) {
    if (widget.gradient != null) return widget.gradient;

    if (widget.type == AppButtonType.primaryGradient) {
      return LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          cs.primary,
          cs.primary.withValues(alpha: 0.85),
          cs.secondary.withValues(alpha: 0.75),
        ],
      );
    }

    return null;
  }

  List<BoxShadow> _getShadows(ColorScheme cs) {
    if (widget.customShadows != null) return widget.customShadows!;

    final isDark = cs.brightness == Brightness.dark;

    switch (widget.type) {
      case AppButtonType.primaryGradient:
        return [
          BoxShadow(
            color: cs.shadow.withValues(alpha: isDark ? 0.3 : 0.1),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: -2,
          ),
        ];
      case AppButtonType.danger:
        return [
          BoxShadow(
            color: cs.error.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: -2,
          ),
        ];
      case AppButtonType.custom:
        return [
          BoxShadow(
            color: cs.shadow.withValues(alpha: isDark ? 0.3 : 0.1),
            blurRadius: 16,
            offset: const Offset(0, 6),
            spreadRadius: -2,
          ),
        ];
      case AppButtonType.primary:
        return [
          BoxShadow(
            color: cs.primary.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: cs.secondary.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 12),
            spreadRadius: -4,
          ),
        ];
    }
  }

  Border _getBorder(ColorScheme cs) {
    if (widget.border != null) return widget.border!;

    final isDark = cs.brightness == Brightness.dark;
    final borderColor =
        widget.borderColor ??
        (isDark
            ? Colors.white.withValues(alpha: 0.1)
            : Colors.white.withValues(alpha: 0.3));

    return Border.all(color: borderColor, width: widget.borderWidth ?? 1.5);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = cs.brightness == Brightness.dark;

    if (widget.isLoading) {
      return _buildLoadingButton(cs, isDark);
    }

    final buttonChild = Container(
      width: widget.width ?? double.infinity,
      height: widget.height,
      decoration: BoxDecoration(
        color: _getBackgroundColor(cs),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
        border: _getBorder(cs),
        boxShadow: _isPressed ? [] : _getShadows(cs),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
        child: widget.enableGlassEffect
            ? BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: widget.glassBlur,
                  sigmaY: widget.glassBlur,
                ),
                child: _buildButtonContent(cs),
              )
            : _buildButtonContent(cs),
      ),
    );

    if (!widget.enablePressAnimation) {
      return GestureDetector(onTap: widget.onPressed, child: buttonChild);
    }

    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTapDown: (_) {
          setState(() => _isPressed = true);
          _controller.forward();
        },
        onTapUp: (_) {
          setState(() => _isPressed = false);
          _controller.reverse();
          widget.onPressed?.call();
        },
        onTapCancel: () {
          setState(() => _isPressed = false);
          _controller.reverse();
        },
        child: buttonChild,
      ),
    );
  }

  Widget _buildButtonContent(ColorScheme cs) {
    return Container(
      padding:
          widget.padding ??
          const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      decoration: BoxDecoration(gradient: _getGradient(cs)),
      child: Row(
        mainAxisAlignment: widget.alignment ?? MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) ...[
            Icon(
              widget.icon,
              color: _getTextColor(cs),
              size: widget.iconSize ?? 22,
            ),
            SizedBox(width: widget.iconSpacing ?? 10),
          ],
          AppText(
            widget.title,
            style: TextStyle(
              fontSize: widget.fontSize ?? 16,
              overflow: TextOverflow.ellipsis,
              fontWeight: widget.fontWeight ?? FontWeight.w600,
              color: _getTextColor(cs),
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------
  // LOADING STATE
  // ------------------------------------------
  Widget _buildLoadingButton(ColorScheme cs, bool isDark) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
        border: Border.all(
          color: cs.outlineVariant.withValues(alpha: 0.5),
          width: widget.borderWidth ?? 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding:
                widget.padding ??
                const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  isDark
                      ? Colors.white.withValues(alpha: 0.05)
                      : Colors.white.withValues(alpha: 0.5),
                  isDark
                      ? Colors.white.withValues(alpha: 0.02)
                      : Colors.white.withValues(alpha: 0.2),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      cs.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                AppText(
                  widget.loadingTitle,
                  style: TextStyle(
                    fontSize: widget.fontSize ?? 16,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: widget.fontWeight ?? FontWeight.w600,
                    color: cs.onSurfaceVariant,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
