import '../../../../config/router/app_router.gr.dart';
import '../../../../config/theme/app_color_scheme.dart';
import '../../../../core/constants/exports.dart';
import '../../../shared/presentation/widgets/action_button.dart';
import '../../../shared/presentation/widgets/app_text.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  static const _tmdbSignupUrl = 'https://www.themoviedb.org/signup';

  Future<void> _openTmdbSignup() async {
    final uri = Uri.parse(_tmdbSignupUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_tmdbSignupUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    return AppScaffold(
      showBackButton: true,
      title: context.locale.signUp,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            const Spacer(),

            Icon(
              SolarIconsOutline.userPlusRounded,
              size: 100,
              color: cs.primary.withValues(alpha: 0.8),
            ),

            const SizedBox(height: 30),

            AppText(
              context.locale.signUp,
              style: context.textTheme.headlineMedium,
              align: TextAlign.center,
            ),

            const SizedBox(height: 32),

            AppText(
              context.locale.signUpDescription,
              style: context.textTheme.labelMedium,
              align: TextAlign.center,
            ),

            const SizedBox(height: 80),

            ActionButton(
              title: context.locale.openTmdbWebsite,
              width: 260,
              height: 65,
              borderRadius: 20,
              type: AppButtonType.custom,
              gradient: LinearGradient(
                colors: [
                  cs.primary.withValues(alpha: 0.8),
                  cs.secondary.withValues(alpha: 0.8),
                ],
              ),
              borderWidth: 0,
              textColor: cs.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              onPressed: _openTmdbSignup,
            ),

            const SizedBox(height: 28),

            ActionButton(
              height: 65,
              title: context.locale.alreadyHaveAccount,
              width: 260,
              borderRadius: 20,
              type: AppButtonType.custom,
              backgroundColor: cs.primary.withValues(alpha: 0.5),
              textColor: cs.textPrimary,
              fontSize: 13,
              borderWidth: 0,
              fontWeight: FontWeight.w700,
              onPressed: () => context.replaceRoute(LoginRoute()),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
