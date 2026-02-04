import 'dart:math' as math;

abstract class NumberFormatter {
  NumberFormatter._();

  static String compact(num value, {int decimalPlaces = 1}) {
    if (value < 1000) {
      return value.toString();
    }

    if (value < 1_000_000) {
      return _format(value, 1000, 'k', decimalPlaces);
    }

    if (value < 1_000_000_000) {
      return _format(value, 1_000_000, 'M', decimalPlaces);
    }

    return _format(value, 1_000_000_000, 'B', decimalPlaces);
  }

  static String _format(
    num value,
    num divisor,
    String suffix,
    int decimalPlaces,
  ) {
    final scaled = value / divisor;

    final factor = math.pow(10, decimalPlaces);
    final truncated = (scaled * factor).floor() / factor;

    final text = truncated
        .toStringAsFixed(decimalPlaces)
        .replaceAll(RegExp(r'\.?0+$'), '');

    return '$text$suffix';
  }
}
