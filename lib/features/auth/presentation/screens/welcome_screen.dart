import 'package:tmda/config/theme/app_color_scheme.dart';
import '../../../../config/router/app_router.gr.dart';
import '../../../../core/constants/exports.dart';
import '../../../shared/presentation/widgets/action_button.dart';
import '../../../shared/presentation/widgets/app_asset_image.dart';
import '../../../shared/presentation/widgets/app_text.dart';

@RoutePage()
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    return AppScaffold(
      appbarSize: 0,
      showBackButton: false,
      body: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Opacity(opacity: value, child: child);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21),
          child: Column(
            children: [
              const SizedBox(height: 180),

              Center(child: AppAssetImage(Pngs.tmda, width: 260, height: 260)),

              const SizedBox(height: 40),

              AppText(
                context.locale.welcomeHeadline,
                style: context.textTheme.titleLarge,
                align: TextAlign.center,
              ),

              const SizedBox(height: 70),

              ActionButton(
                title: context.locale.login,
                width: 200,
                borderRadius: 20,
                type: AppButtonType.custom,
                gradient: LinearGradient(
                  colors: [
                    cs.primary.withValues(alpha: 0.8),
                    cs.secondary.withValues(alpha: 0.8),
                  ],
                ),
                borderWidth: 2,
                border: Border.all(),
                borderColor: cs.border,
                textColor: cs.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                enableGlassEffect: false,

                customShadows: [
                  BoxShadow(
                    color: cs.shadow.withValues(alpha: 0.2),
                    blurRadius: 12,
                  ),
                ],
                onPressed: () => context.pushRoute(LoginRoute()),
              ),

              const SizedBox(height: 20),

              ActionButton(
                title: context.locale.signUp,
                width: 200,
                borderRadius: 20,
                type: AppButtonType.custom,
                backgroundColor: cs.primary.withValues(alpha: 0.5),
                enableGlassEffect: false,
                textColor: cs.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                onPressed: () => context.pushRoute(
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
      ),
    );
  }
}
