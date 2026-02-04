import 'package:tmda/features/watchlist/presentation/cubits/watchlist_cubit.dart';
import '../../core/constants/exports.dart';
import '../../features/auth/presentation/cubits/auth_cubit.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  final AppPreferences prefs;
  AppRouter(this.prefs);

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    CustomRoute(
      page: StartupRedirectRoute.page,
      initial: true,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      duration: Duration(milliseconds: 400),
    ),

    CustomRoute(
      page: UnauthenticatedRoutes.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      duration: Duration(milliseconds: 400),
      children: [
        CustomRoute(
          page: WelcomeRoute.page,
          initial: true,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          duration: Duration(milliseconds: 400),
        ),
        CustomRoute(
          page: LoginRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          duration: Duration(milliseconds: 400),
        ),
        CustomRoute(
          page: SignupRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          duration: Duration(milliseconds: 400),
        ),
      ],
    ),

    CustomRoute(
      page: AuthenticatedRoutes.page,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      duration: Duration(milliseconds: 400),
      children: [
        CustomRoute(
          initial: true,
          page: MainRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          duration: Duration(milliseconds: 400),
          children: [
            CustomRoute(
              initial: true,

              page: MoviesRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 400),
            ),
            CustomRoute(
              page: TvRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 400),
            ),
            CustomRoute(
              page: SearchRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 400),
            ),
            CustomRoute(
              page: ProfileRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              duration: Duration(milliseconds: 400),
            ),
          ],
        ),
        CustomRoute(
          page: MoviesDetailsRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          duration: Duration(milliseconds: 400),
        ),
        CustomRoute(
          page: SeeAllMoviesRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          duration: Duration(milliseconds: 400),
        ),
        CustomRoute(
          page: TvDetailsRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          duration: Duration(milliseconds: 400),
        ),
        CustomRoute(
          page: SeeAllTvRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          duration: Duration(milliseconds: 400),
        ),
        CustomRoute(
          page: MoviesWatchlistRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          duration: Duration(milliseconds: 400),
        ),
        CustomRoute(
          page: ActorDetailsRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          duration: Duration(milliseconds: 400),
        ),
        CustomRoute(
          page: TvWatchlistRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          duration: Duration(milliseconds: 400),
        ),
        CustomRoute(
          page: TrailerRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          duration: Duration(milliseconds: 400),
        ),
      ],
    ),
  ];
}

@RoutePage(name: 'AuthenticatedRoutes')
class AuthenticatedRoute extends AutoRouter implements AutoRouteWrapper {
  const AuthenticatedRoute({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<WatchlistCubit>()..load()),
      ],
      child: this,
    );
  }
}

@RoutePage(name: 'UnauthenticatedRoutes')
class UnauthenticatedRoute extends AutoRouter implements AutoRouteWrapper {
  const UnauthenticatedRoute({super.key});
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (context) => getIt<AuthCubit>(), child: this);
  }
}
