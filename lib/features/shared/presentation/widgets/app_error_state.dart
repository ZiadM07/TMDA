import '../../../../core/constants/exports.dart';
import 'action_button.dart';
import 'app_text.dart';

class AppErrorState extends StatelessWidget {
  final String? message;
  final void Function()? onPressed;
  const AppErrorState({super.key, this.message, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(SolarIconsOutline.dangerCircle, size: 40, color: cs.error),
          SizedBox(height: 16),
          AppText(
            message ?? context.locale.somethingWentWrong,
            align: TextAlign.center,
            size: 16,
            weight: FontWeight.w500,
            color: cs.error,
          ),
          SizedBox(height: 16),
          ActionButton(
            onPressed: onPressed,
            title: context.locale.retry,
            type: AppButtonType.custom,
            gradient: LinearGradient(
              colors: [
                cs.primary.withValues(alpha: 0.8),
                cs.secondary.withValues(alpha: 0.8),
              ],
            ),
          ),
        ],
      ).addPadding(horizontal: 16),
    );
  }
}
