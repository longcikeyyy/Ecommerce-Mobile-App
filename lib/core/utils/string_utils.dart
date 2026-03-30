class StringUtils {
  StringUtils._();

  static bool isNullOrEmpty(String? value) =>
      value == null || value.trim().isEmpty;

  static String capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1).toLowerCase();
  }

  static String capitalizeWords(String value) {
    if (value.isEmpty) return value;
    return value
        .trim()
        .split(RegExp(r'\s+'))
        .map((word) => capitalize(word))
        .join(' ');
  }

  static String truncate(String value, int maxLength, {String ellipsis = '...'}) {
    if (value.length <= maxLength) return value;
    return '${value.substring(0, maxLength)}$ellipsis';
  }

  static String removeWhitespace(String value) => value.replaceAll(' ', '');

  static String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final name = parts[0];
    final domain = parts[1];
    if (name.length <= 2) return email;
    return '${name[0]}${'*' * (name.length - 2)}${name[name.length - 1]}@$domain';
  }

  static String formatCurrency(double amount, {String symbol = '\$'}) {
    return '$symbol${amount.toStringAsFixed(2)}';
  }

  static String toSlug(String value) {
    return value
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '-');
  }
}
