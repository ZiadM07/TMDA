import 'package:intl/intl.dart' as localization;

import '../../l10n/app_localizations.dart';
import '../constants/exports.dart';

extension BuildContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;

  FocusScopeNode get focusScope => FocusScope.of(this);

  bool isKeyboardClosed() => MediaQuery.of(this).viewInsets.bottom <= 0;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  AppLocalizations get locale => AppLocalizations.of(this)!;

  bool get isTablet {
    final shortestSide = MediaQuery.of(this).size.shortestSide;
    return shortestSide > 550;
  }

  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;

  TextDirection get currentTextDirection {
    if (localization.Intl.getCurrentLocale() == 'ar') {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }

  bool get isGestureNavigation {
    if (Platform.isIOS) return true;
    final gestureInsets = MediaQuery.of(this).systemGestureInsets;
    return gestureInsets.left > 0 || gestureInsets.right > 0;
  }

  TextTheme get textTheme => Theme.of(this).textTheme;

  double get bottomInsets => MediaQuery.of(this).viewInsets.bottom;

  bool get isEnglishLanguage => localization.Intl.getCurrentLocale() == 'en';

  String obfuscateEmail(String email) {
    final emailParts = email.split('@');
    final localPart = emailParts[0];
    final domainPart = emailParts[1];

    if (localPart.length < 2) {
      return email;
    }

    final firstVisiblePart = localPart.substring(0, 2);
    final obfuscatedPart = '•' * (localPart.length);
    final lastVisiblePart = localPart.substring(
      localPart.length - 2,
      localPart.length,
    );

    return '$firstVisiblePart $obfuscatedPart $lastVisiblePart@$domainPart';
  }

  String obfuscatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length <= 6) {
      return '$this******';
    }

    final countryCode = phoneNumber.startsWith('+')
        ? phoneNumber.substring(0, phoneNumber.indexOf(RegExp(r'\d')))
        : '';
    final rest = phoneNumber.replaceFirst(countryCode, '');

    if (rest.length <= 4) {
      return '$countryCode******';
    } else {
      final visibleStart = rest.substring(0, 2);
      final visibleEnd = rest.substring(rest.length - 2);
      return '$countryCode$visibleStart******$visibleEnd';
    }
  }
}

extension MoneyFormatExt on double {
  String formatMoney() {
    final bool isArabic = TmdaApp.isArabic;
    final value = this;

    // Less than 1000 → show as is
    if (value < 1000) {
      final clean = value % 1 == 0
          ? value.toInt().toString()
          : value.toString();
      return clean;
    }

    // Thousands
    if (value < 1_000_000) {
      final k = value / 1000;
      final formatted = k % 1 == 0
          ? k.toStringAsFixed(0)
          : k.toStringAsFixed(1);
      final clean = formatted.replaceAll(".0", "");

      return isArabic ? "$clean الاف" : "${clean}k";
    }

    // Millions
    final m = value / 1_000_000;
    final formatted = m % 1 == 0 ? m.toStringAsFixed(0) : m.toStringAsFixed(1);
    final clean = formatted.replaceAll(".0", "");

    return isArabic ? "$clean مليون" : "${clean}m";
  }
}

extension ColorExtension on Color {
  String asHexString({bool leadingHashSign = true}) {
    return '${leadingHashSign ? '#' : ''}'
        '${toARGB32().toRadixString(16).substring(3).toUpperCase()}';
  }
}

extension StringExtension on String {
  Color toHexColor({bool hasLeadingHashSign = true}) {
    String hexColor = this;
    if (hasLeadingHashSign && hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }

    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    final colorInt = int.parse(hexColor, radix: 16);
    return Color(colorInt);
  }
}

extension FileSizeValidator on File {
  bool validateSize({double maxSizeInMB = 5.0}) {
    int maxSizeInBytes = (maxSizeInMB * 1024 * 1024).toInt();
    int fileSize = lengthSync();
    return fileSize < maxSizeInBytes;
  }
}

extension LimitListExtension<T> on List<T> {
  List<T> limit([int limit = AppConstants.defaultCardsLimit]) {
    if (length <= limit) return this;
    return take(limit).toList();
  }
}

extension StringExt on String {
  bool get isVideoFile {
    if (isEmpty) return false;

    final lowerCasePath = toLowerCase();

    final videoExtensions = [
      '.mp4',
      '.webm',
      '.ogg',
      '.mov',
      '.avi',
      '.mkv',
      '.flv',
      '.wmv',
      '.m4v',
      '.mpg',
      '.mpeg',
      '.3gp',
      '.ogv',
      '.ts',
      '.mts',
      '.m2ts',
      '.divx',
      '.asf',
      '.rm',
      '.rmvb',
    ];

    return videoExtensions.any((ext) => lowerCasePath.endsWith(ext));
  }

  bool get isPhotoFile {
    if (isEmpty) return false;

    final lowerCasePath = toLowerCase();
    final photoExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];

    return photoExtensions.any((ext) => lowerCasePath.endsWith(ext));
  }
}

extension PaddingEx on Widget {
  Widget addPadding({
    final double all = 0.0,
    final double horizontal = 0.0,
    final double vertical = 0.0,
    final double start = 0.0,
    final double bottom = 0.0,
    final double end = 0.0,
    final double left = 0.0,
    final double right = 0.0,
    final double top = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.all(all),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontal,
          vertical: vertical,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: left, right: right),
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: start,
              bottom: bottom,
              end: end,
              top: top,
            ),
            child: this,
          ),
        ),
      ),
    );
  }

  Widget addAction({
    Function? onTap,
    Function? onTapOutside,
    Key? key,
    Function? onBounce,
    EdgeInsetsGeometry padding = EdgeInsets.zero,
    Alignment? alignment,
  }) {
    final child = Container(
      color: Colors.transparent,
      alignment: alignment,
      padding: padding,
      child: this,
    );

    Widget content;

    if (onBounce != null) {
      content = BouncingWidget(
        key: key,
        scaleFactor: 2,
        onPressed: () => onBounce(),
        child: child,
      );
    } else if (onTap != null) {
      content = GestureDetector(key: key, onTap: () => onTap(), child: child);
    } else {
      content = child;
    }

    if (onTapOutside != null) {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => onTapOutside(),
            behavior: HitTestBehavior.translucent,
            child: Container(
              color: Colors.transparent,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          content,
        ],
      );
    }

    return content;
  }
}
