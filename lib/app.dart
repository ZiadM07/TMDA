import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tmda/route_observer.dart';
import 'core/state/app_state.dart';
import 'core/constants/exports.dart';
import 'core/utils/responsive_wrapper.dart';
import 'features/shared/presentation/cubits/app_cubit.dart';
import 'l10n/app_localizations.dart';

class TmdaApp extends StatefulWidget {
  static late AppLocalizations locale;
  static late bool isDarkTheme;
  static late bool isArabic;
  static late BuildContext context;
  const TmdaApp({super.key});

  @override
  State<TmdaApp> createState() => _TmdaAppState();
}

class _TmdaAppState extends State<TmdaApp> with WidgetsBindingObserver {
  late final AppCubit appCubit;
  late final AppRouter appRouter;

  @override
  void initState() {
    appCubit = getIt<AppCubit>();
    appRouter = getIt<AppRouter>();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appCubit,
      child: ResponsiveWrapper(
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final cubit = context.read<AppCubit>();
            TmdaApp.isDarkTheme = cubit.appThemeMode.isDarkTheme;

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              theme: cubit.appThemeMode.data,
              routerConfig: appRouter.config(
                navigatorObservers: () => [
                  MyRouteObserver(),
                  AutoRouteObserver(),
                ],
              ),
              onGenerateTitle: (context) {
                TmdaApp.locale = AppLocalizations.of(context)!;
                TmdaApp.isArabic = cubit.locale.languageCode == 'ar';
                return '';
              },
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              locale: cubit.locale,
            );
          },
        ),
      ),
    );
  }
}
