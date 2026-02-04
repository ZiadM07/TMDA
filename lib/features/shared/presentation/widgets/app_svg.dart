import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/exports.dart';

class AppSvg extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final AlignmentGeometry alignment;

  const AppSvg(
    this.path, {
    super.key,
    this.height = 25,
    this.width = 25,
    this.fit = BoxFit.contain,
    this.color,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      key: key,
      alignment: alignment,
    );
  }
}
