import '../../../../core/constants/exports.dart';
import '../../../shared/presentation/widgets/action_button.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const LoginButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      title: context.locale.login,
      borderRadius: 18,
      height: 60,
      type: AppButtonType.custom,
      gradient: LinearGradient(
        colors: [
          context.colorScheme.primary.withValues(alpha: 0.8),
          context.colorScheme.secondary.withValues(alpha: 0.8),
        ],
      ),
      borderWidth: 0,
      textColor: context.colorScheme.onSurface,
      fontSize: 16,
      fontWeight: FontWeight.w700,
      onPressed: isLoading ? null : onPressed,
      isLoading: isLoading,
    );
  }
}
