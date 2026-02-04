import '../../../core/constants/exports.dart';

class MainNavController extends StatelessWidget {
  final TabsRouter tabsRouter;
  final List<PageRouteInfo> tabs;
  final Widget child;

  const MainNavController({
    super.key,
    required this.tabsRouter,
    required this.tabs,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canPop(),
      onPopInvokedWithResult: _onPopInvokedWithResult,
      child: child,
    );
  }

  bool _canPop() {
    // Only allow system back if we're already on the first tab
    return tabsRouter.activeIndex == 0;
  }

  void _onPopInvokedWithResult(bool didPop, dynamic result) {
    if (didPop) return;
    if (tabsRouter.activeIndex > 0) {
      tabsRouter.setActiveIndex(tabsRouter.activeIndex - 1);
      if (result != null) {
        tabsRouter.current.router.pop(result);
      }
    }
  }

  void onTabSelected(int index) {
    if (tabsRouter.activeIndex == index) {
      // Reselect → pop to root of current tab
      tabsRouter.current.router.maybePopTop();
    } else {
      tabsRouter.setActiveIndex(index);
    }
  }
}
