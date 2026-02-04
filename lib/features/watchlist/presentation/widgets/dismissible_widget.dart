import 'dart:ui';

import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';

class DismissibleWidget extends StatefulWidget {
  final Widget child;
  final Color color;
  final VoidCallback onDismissed;
  final Key dismissibleKey;

  const DismissibleWidget({
    super.key,
    required this.child,
    required this.color,
    required this.onDismissed,
    required this.dismissibleKey,
  });

  @override
  State<DismissibleWidget> createState() => _DismissibleWidgetState();
}

class _DismissibleWidgetState extends State<DismissibleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isDismissing = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: widget.dismissibleKey,
      direction: DismissDirection.startToEnd,
      dismissThresholds: const {DismissDirection.startToEnd: 0.4},
      onUpdate: (details) {
        if (details.progress > 0.3 && !_isDismissing) {
          HapticFeedback.selectionClick();
          setState(() => _isDismissing = true);
        } else if (details.progress <= 0.3 && _isDismissing) {
          setState(() => _isDismissing = false);
        }
      },
      confirmDismiss: (_) async {
        widget.onDismissed();
        return true;
      },
      background: _DismissBackground(isDismissing: _isDismissing),
      child: widget.child,
    ).addPadding(horizontal: 20, vertical: 10);
  }
}

class _DismissBackground extends StatelessWidget {
  final bool isDismissing;

  const _DismissBackground({required this.isDismissing});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: isDismissing ? 20 : 10,
          sigmaY: isDismissing ? 20 : 10,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.black.withValues(alpha: isDismissing ? 0.5 : 0.3)
                : Colors.white.withValues(alpha: isDismissing ? 0.5 : 0.3),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: cs.error.withValues(alpha: isDismissing ? 0.6 : 0.3),
              width: isDismissing ? 2 : 1,
            ),
            boxShadow: isDismissing
                ? [
                    BoxShadow(
                      color: cs.error.withValues(alpha: 0.2),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cs.error.withValues(alpha: isDismissing ? 0.3 : 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  SolarIconsOutline.trashBinTrash,
                  color: cs.error,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              AppText(
                context.locale.remove,
                size: 16,
                weight: FontWeight.w400,
                color: cs.error,
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_rounded, color: cs.error, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}
