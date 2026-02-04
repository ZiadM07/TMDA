
import 'package:auto_size_text/auto_size_text.dart';
import '../../../../core/constants/exports.dart';
import '../../../../core/utils/app_padding.dart';

class AppText extends StatelessWidget {
  final String text;
  final Color? color;
  final double size;
  final String? fontFamily;
  final int? maxLines;
  final TextAlign? align;
  final double? maxWidth;
  final double? height;
  final TextDecoration decoration;
  final FontWeight? weight;
  final TextDirection? direction;
  final TextStyle? style;
  final bool autoSized;
  final TextOverflow? overflow;

  const AppText(
    this.text, {
    super.key,
    this.fontFamily,
    this.style,
    this.weight,
    this.color,
    this.size = 20,
    this.maxLines,
    this.align,
    this.maxWidth,
    this.height,
    this.direction,
    this.autoSized = true,
    this.decoration = TextDecoration.none,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    if (maxWidth != null) {
      return ConstrainedBox(
        key: key,
        constraints: BoxConstraints(maxWidth: maxWidth!),
        child: gText(context),
      );
    } else {
      return gText(context);
    }
  }

  Widget gText(BuildContext context) {
    TextStyle defaultStyle = TextStyle(
      color: color ?? context.colorScheme.onSurface,
      fontFamily: fontFamily,
      fontSize: size,
      decoration: decoration,

      decorationStyle: TextDecorationStyle.solid,
      decorationThickness: 1.4,
      height: height ?? 1.3,
      fontWeight: weight ?? FontWeight.w500,
    );
    if (!autoSized) {
      return Text(
        text,
        style: style ?? defaultStyle,
        maxLines: maxLines,
        overflow: overflow ?? (maxLines != null ? TextOverflow.ellipsis : null),
        textAlign: align,

        textDirection:
            direction ??
            (isArabic(text) ? TextDirection.rtl : TextDirection.ltr),
      ).addAction(padding: AppPadding.set());
    }
    return AutoSizeText(
      text,
      style: style ?? defaultStyle,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,

      textAlign: align,
      textDirection:
          direction ?? (isArabic(text) ? TextDirection.rtl : TextDirection.ltr),
    );
  }

  bool isArabic(String text) {
    // Arabic Unicode character ranges
    final arabicRegex = RegExp(
      r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]',
    );

    // Check if the string contains Arabic characters
    return arabicRegex.hasMatch(text);
  }
}
