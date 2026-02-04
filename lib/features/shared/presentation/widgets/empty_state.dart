import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String description;
  const EmptyState({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          Icon(
            SolarIconsOutline.bookmark,
            size: 40,
            color: context.colorScheme.primary,
          ),
          AppText(
            title,
            style: context.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: context.colorScheme.onSurface,
            ),
            align: TextAlign.center,
          ),
          AppText(
            description,
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
            align: TextAlign.center,
          ),
        ],
      ).addPadding(horizontal: 16),
    );
  }
}
