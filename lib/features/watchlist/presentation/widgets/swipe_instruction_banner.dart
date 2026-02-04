import 'package:tmda/features/shared/presentation/widgets/app_text.dart';

import '../../../../core/constants/exports.dart';

class SwipeInstructionBanner extends StatefulWidget {
  final String message;

  const SwipeInstructionBanner({super.key, required this.message});

  @override
  State<SwipeInstructionBanner> createState() => _SwipeInstructionBannerState();
}

class _SwipeInstructionBannerState extends State<SwipeInstructionBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isDismissed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && !_isDismissed) _dismiss();
    });
  }

  void _dismiss() {
    setState(() => _isDismissed = true);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    if (_isDismissed && _controller.isDismissed) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.swipe_right_rounded, color: colorScheme.primary),
              const SizedBox(width: 12),
              Expanded(
                child: AppText(
                  widget.message,
                  color: colorScheme.onPrimaryContainer,
                  size: 14,
                  weight: FontWeight.w400,
                ),
              ),
              Icon(
                Icons.close_rounded,
                color: colorScheme.onPrimaryContainer.withValues(alpha: 0.6),
              ).addAction(onTap: _dismiss),
            ],
          ),
        ),
      ),
    );
  }
}
