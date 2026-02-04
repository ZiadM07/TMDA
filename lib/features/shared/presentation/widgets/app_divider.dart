import 'package:tmda/config/theme/app_color_scheme.dart';
import 'package:tmda/core/constants/exports.dart';

class AppDivider extends StatelessWidget {
  final double? horizontalPadding;
  const AppDivider({super.key, this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: context.colorScheme.textSecondary,
      height: 0.5,
      thickness: 0.5,
      indent: 0,
      endIndent: 0,
    ).addPadding(horizontal: horizontalPadding ?? 35.0);
  }
}
