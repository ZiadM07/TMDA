import '../../../../core/constants/exports.dart';
import '../../../shared/presentation/widgets/app_text.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: AppText(
            context.locale.welcomeToOurCommunity,
            align: TextAlign.center,
            style: context.textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: AppText(
            context.locale.signInToContinue,
            align: TextAlign.center,
            style: context.textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
