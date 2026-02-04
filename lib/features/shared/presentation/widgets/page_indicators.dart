import '../../../../core/constants/exports.dart';

class PageIndicators extends StatelessWidget {
  final int length;
  final int currentIndex;
  final ColorScheme colorScheme;

  const PageIndicators({
    super.key,
    required this.length,
    required this.currentIndex,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentIndex == i ? 28 : 8,
          decoration: BoxDecoration(
            color: currentIndex == i
                ? colorScheme.primary
                : colorScheme.primary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
