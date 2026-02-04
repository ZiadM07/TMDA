import '../../../../config/router/app_router.gr.dart';
import '../../../../core/constants/exports.dart';
import '../../../../core/state/app_state.dart';
import '../../../shared/presentation/widgets/app_loading.dart';
import '../cubits/startup_cubit.dart';

@RoutePage()
class StartupRedirectScreen extends StatelessWidget {
  const StartupRedirectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<StartupCubit>()..decideStartRoute(),
      child: BlocListener<StartupCubit, AppState<bool>>(
        listenWhen: (prev, curr) =>
            curr.status == StateStatus.success ||
            curr.status == StateStatus.error,
        listener: (context, state) {
          if (state.status == StateStatus.success && state.data == true) {
            context.replaceRoute(const AuthenticatedRoutes());
          } else {
            context.replaceRoute(const UnauthenticatedRoutes());
          }
        },
        child: AppScaffold(
          showBackButton: false,
          body: Center(child: Loading.loader(context)),
        ),
      ),
    );
  }
}
