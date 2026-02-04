import 'dart:ui';

import 'package:tmda/config/theme/app_color_scheme.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';

/// A modern 2026-style logout confirmation dialog with glassmorphism and animations
class LogoutConfirmationDialog extends StatefulWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;

  const LogoutConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  static void show({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onConfirm,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return LogoutConfirmationDialog(
          title: title,
          content: content,
          onConfirm: () {
            Future.microtask(() => onConfirm());
            Future.microtask(() {
              if (!context.mounted) return;
              Navigator.pop(dialogContext);
            });
          },
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        // Smooth scale and fade animation
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return ScaleTransition(
          scale: Tween<double>(begin: 0.85, end: 1.0).animate(curvedAnimation),
          child: FadeTransition(opacity: curvedAnimation, child: child),
        );
      },
    );
  }

  @override
  State<LogoutConfirmationDialog> createState() =>
      _LogoutConfirmationDialogState();
}

class _LogoutConfirmationDialogState extends State<LogoutConfirmationDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _iconAnimation;
  late Animation<double> _contentAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _iconAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
    );

    _contentAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
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
    final cs = context.colorScheme;
    final isLight = cs.isLightMode();

    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            // Glassmorphism effect
            color: isLight ? cs.surface : cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: isLight ? cs.border : cs.lightBorder,
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Animated Icon with Gradient Background
                    ScaleTransition(
                      scale: _iconAnimation,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              cs.error.withValues(alpha: 0.15),
                              cs.error.withValues(alpha: 0.08),
                            ],
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: cs.error.withValues(alpha: 0.2),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: cs.error.withValues(alpha: 0.15),
                              blurRadius: 20,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Icon(
                          SolarIconsOutline.logout_2,
                          size: 38,
                          color: cs.error,
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// Title with Fade Animation
                    FadeTransition(
                      opacity: _contentAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(_contentAnimation),
                        child: AppText(
                          widget.title,
                          size: 24,
                          weight: FontWeight.w700,
                          align: TextAlign.center,
                          height: 1.3,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    /// Content with Fade Animation
                    FadeTransition(
                      opacity: _contentAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(_contentAnimation),
                        child: AppText(
                          widget.content,
                          size: 15,
                          color: cs.textTertiary,
                          align: TextAlign.center,
                          height: 1.5,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    /// Action Buttons with Modern Design
                    FadeTransition(
                      opacity: _contentAnimation,
                      child: Row(
                        children: [
                          /// Cancel Button
                          Expanded(
                            child: _ModernButton(
                              onPressed: () => Navigator.pop(context),
                              backgroundColor: isLight
                                  ? cs.surfaceContainerHigh
                                  : cs.surfaceContainerHigh,
                              foregroundColor: cs.onSurface,
                              borderColor: cs.outline.withValues(alpha: 0.2),
                              child: AppText(
                                context.locale.cancel,
                                size: 16,
                                weight: FontWeight.w600,
                                color: cs.textPrimary,
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          /// Logout Button
                          Expanded(
                            child: _ModernButton(
                              onPressed: widget.onConfirm,
                              backgroundColor: cs.error,
                              foregroundColor: cs.onError,
                              hasGradient: true,
                              child: AppText(
                                context.locale.logout,
                                size: 16,
                                weight: FontWeight.w600,
                                color: cs.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Modern button widget with hover effects and animations
class _ModernButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;
  final bool hasGradient;

  const _ModernButton({
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    this.hasGradient = false,
  });

  @override
  State<_ModernButton> createState() => _ModernButtonState();
}

class _ModernButtonState extends State<_ModernButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            gradient: widget.hasGradient
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      widget.backgroundColor,
                      widget.backgroundColor.withValues(alpha: 0.85),
                    ],
                  )
                : null,
            color: widget.hasGradient ? null : widget.backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: widget.borderColor != null
                ? Border.all(color: widget.borderColor!, width: 1.5)
                : null,
            boxShadow: widget.hasGradient
                ? [
                    BoxShadow(
                      color: cs.error.withValues(alpha: 0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                      spreadRadius: -2,
                    ),
                  ]
                : null,
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}
