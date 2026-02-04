import 'package:tmda/config/router/app_router.gr.dart';
import '../../core/constants/exports.dart';
import 'widgets/main_bottom_nav.dart';
import 'widgets/main_nav_controller.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  static const _tabs = [
    MoviesRoute(),
    TvRoute(),
    SearchRoute(),
    ProfileRoute(),
  ];

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      routes: _tabs,
      bottomNavigationBuilder: (context, tabsRouter) {
        return MainNavController(
          tabsRouter: tabsRouter,
          tabs: _tabs,
          child: MainBottomNav(
            activeIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
          ),
        );
      },
    );
  }
}
