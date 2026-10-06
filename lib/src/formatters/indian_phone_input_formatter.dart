import 'base/indian_input_formatter.dart';

/// Formats Indian mobile numbers as the user types.
///
/// - Auto-inserts `+91 ` prefix on the first digit.
/// - Groups digits as 5 + 5: `+91 98765 43210`.
/// - Handles paste of `9876543210`, `09876543210`, `+919876543210`,
///   and `919876543210`.
class IndianPhoneInputFormatter extends IndianInputFormatter {
  /// Creates an [IndianPhoneInputFormatter].
  const IndianPhoneInputFormatter();

  static const String _prefix = '+91 ';
  static const int _maxDigits = 10;

  @override
  String get prefix => _prefix;

  @override
  String strip(String input) {
    String digits = input.replaceAll(RegExp(r'\D'), '');

    // Remove the digits belonging to our prefix if present.
    if (input.startsWith(_prefix)) {
      final prefixDigits = _prefix.replaceAll(RegExp(r'\D'), '').length;
      if (digits.length >= prefixDigits) {
        digits = digits.substring(prefixDigits);
      }
    }

    // Normalise: 12-digit "91XXXXXXXXXX" -> 10 digits.
    // 11-digit "0XXXXXXXXXX" -> 10 digits.
    if (digits.length == 12 && digits.startsWith('91')) {
      digits = digits.substring(2);
    } else if (digits.length == 11 && digits.startsWith('0')) {
      digits = digits.substring(1);
    }

    return digits.length > _maxDigits
        ? digits.substring(0, _maxDigits)
        : digits;
  }

  @override
  String format(String raw) {
    if (raw.isEmpty) return '';
    final buffer = StringBuffer(_prefix);
    for (int i = 0; i < raw.length; i++) {
      if (i == 5) buffer.write(' ');
      buffer.write(raw[i]);
    }
    return buffer.toString();
  }

  @override
  bool isFormattingChar(String char) => char == ' ' || char == '+';
}
