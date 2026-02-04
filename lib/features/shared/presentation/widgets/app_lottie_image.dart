import '../../../../core/constants/exports.dart';
import 'package:lottie/lottie.dart';

class AppLottieImage extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final BoxFit fit;
  final Color? color;
  final double borderRadius;
  final AlignmentGeometry alignment;

  const AppLottieImage(
    this.path, {
    super.key,
    this.borderRadius = 0,
    this.height = 25,
    this.width = 25,
    this.fit = BoxFit.contain,
    this.color,
    this.alignment = Alignment.topCenter,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Lottie.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
      ),
    );
  }
}
