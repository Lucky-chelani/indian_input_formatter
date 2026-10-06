import 'base/indian_input_formatter.dart';

/// Sanitises UPI ID input as the user types.
///
/// - Removes spaces.
/// - Allows letters, digits, `.`, `-`, `_`, and a single `@`.
/// - Preserves case.
class UpiIdInputFormatter extends IndianInputFormatter {
  /// Creates a [UpiIdInputFormatter].
  const UpiIdInputFormatter();

  @override
  String strip(String input) {
    final cleaned = input.replaceAll(RegExp(r'[^A-Za-z0-9.\-_@]'), '');
    // Keep only the first '@'.
    final firstAt = cleaned.indexOf('@');
    if (firstAt == -1) return cleaned;
    return cleaned.substring(0, firstAt + 1) +
        cleaned.substring(firstAt + 1).replaceAll('@', '');
  }

  @override
  String format(String raw) => raw;

  @override
  bool isFormattingChar(String char) => false;
}
