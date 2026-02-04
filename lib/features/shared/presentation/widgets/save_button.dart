import 'package:tmda/config/theme/app_color_scheme.dart';
import 'package:tmda/core/constants/exports.dart';

class SaveButton extends StatelessWidget {
  final bool isSaved;
  final bool enabled;
  final ColorScheme colorScheme;
  final VoidCallback? onTap;
  final double? size;

  const SaveButton({
    super.key,
    required this.isSaved,
    required this.enabled,
    required this.colorScheme,
    this.onTap,
    this.size = 22,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.4,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                isSaved ? SolarIconsBold.bookmark : SolarIconsOutline.bookmark,
                key: ValueKey(isSaved),
                size: size,
                color: isSaved
                    ? colorScheme.primary
                    : colorScheme.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}