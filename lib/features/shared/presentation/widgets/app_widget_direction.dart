import 'dart:math' as math;

import '../../../../core/constants/exports.dart';

import '../cubits/app_cubit.dart';

class AppWidgetDirection extends StatefulWidget {
  final Widget child;
  const AppWidgetDirection({super.key, required this.child});

  @override
  State<AppWidgetDirection> createState() => _AppWidgetDirectionState();
}

class _AppWidgetDirectionState extends State<AppWidgetDirection> {
  late AppCubit appCubit;

  @override
  void initState() {
    appCubit = context.read<AppCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: appCubit.isArSelected,
      builder: (context, isArSelected, child) {
        double transformY = isArSelected ? math.pi : 0;
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(transformY),
          child: widget.child,
        );
      },
    );
  }
}
