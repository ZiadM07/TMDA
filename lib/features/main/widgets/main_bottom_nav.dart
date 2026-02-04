import 'package:tmda/config/theme/app_color_scheme.dart';

import '../../../core/constants/exports.dart';
import '../../shared/presentation/widgets/app_svg.dart';

class MainBottomNav extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onTap;

  const MainBottomNav({
    super.key,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return RepaintBoundary(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: cs.surface.withValues(alpha: 0.7),

            border: Border(
              top: BorderSide(color: cs.border.withValues(alpha: 0.08)),
            ),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            currentIndex: activeIndex,
            onTap: onTap,
            type: BottomNavigationBarType.fixed,
            items: _items(context),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _items(BuildContext context) {
    return [
      _item(context, index: 0, icon: Svgs.movies),
      _item(context, index: 1, icon: Svgs.series),
      _item(context, index: 2, icon: Svgs.search),
      _item(context, index: 3, icon: Svgs.profile),
    ];
  }

  BottomNavigationBarItem _item(
    BuildContext context, {
    required int index,
    required String icon,
  }) {
    final isActive = activeIndex == index;
    final color = isActive
        ? context.colorScheme.primary
        : context.colorScheme.onSurface.withValues(alpha: 0.7);

    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: AppSvg(icon, color: color),
      ),
      label: '',
    );
  }
}
