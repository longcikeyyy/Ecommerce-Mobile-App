import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static const String _defaultFormat = 'MMM dd, yyyy';
  static const String _timeFormat = 'hh:mm a';
  static const String _fullFormat = 'MMM dd, yyyy • hh:mm a';
  static const String _isoFormat = 'yyyy-MM-dd';

  static String format(DateTime date, {String pattern = _defaultFormat}) {
    return DateFormat(pattern).format(date);
  }

  static String toDateString(DateTime date) =>
      DateFormat(_defaultFormat).format(date);

  static String toTimeString(DateTime date) =>
      DateFormat(_timeFormat).format(date);

  static String toFullString(DateTime date) =>
      DateFormat(_fullFormat).format(date);

  static String toIsoDateString(DateTime date) =>
      DateFormat(_isoFormat).format(date);

  static DateTime? tryParse(String value, {String pattern = _defaultFormat}) {
    try {
      return DateFormat(pattern).parse(value);
    } catch (_) {
      return null;
    }
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isPast(DateTime date) => date.isBefore(DateTime.now());

  static bool isFuture(DateTime date) => date.isAfter(DateTime.now());

  static String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inSeconds < 60) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()}w ago';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()}mo ago';
    return '${(diff.inDays / 365).floor()}y ago';
  }
}
