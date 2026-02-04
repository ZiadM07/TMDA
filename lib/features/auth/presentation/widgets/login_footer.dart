import '../../../../config/router/app_router.gr.dart';
import '../../../../core/constants/exports.dart';
import '../../../shared/presentation/widgets/app_text.dart';

class LoginFooter extends StatelessWidget {
  final bool isLoading;

  const LoginFooter({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              context.locale.dontHaveAnAccount,
              style: context.textTheme.titleSmall,
            ),
            AppText(
              context.locale.signUp,
              size: 14,
              weight: FontWeight.w500,
              color: context.colorScheme.primary,
            ).addAction(
              onTap: isLoading
                  ? null
                  : () => context.pushRoute(
                      AuthWebViewRoute(
                        initialUrl: 'https://www.themoviedb.org/signup',
                        successUrlKeywords: const [
                          '/login',
                          '/account',
                          '/settings',
                          '/u/',
                        ],
                        onSuccessRoute: const LoginRoute(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
