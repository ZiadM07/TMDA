/// Utility class for formatting timestamps
class TimeFormatter {
  /// Format timestamp as relative time (e.g., "5m ago", "2h ago")
  static String formatRelativeTime(int timestampMs) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final diff = now - timestampMs;
    final seconds = diff ~/ 1000;
    final minutes = seconds ~/ 60;
    final hours = minutes ~/ 60;
    final days = hours ~/ 24;

    if (days > 0) return '${days}d ago';
    if (hours > 0) return '${hours}h ago';
    if (minutes > 0) return '${minutes}m ago';
    return '${seconds}s ago';
  }

  /// Format timestamp as short relative time (e.g., "5m", "2h")
  static String formatShortRelativeTime(int timestampMs) {
    final dt = DateTime.fromMillisecondsSinceEpoch(timestampMs);
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inSeconds < 60) return '${diff.inSeconds}s';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }
}

