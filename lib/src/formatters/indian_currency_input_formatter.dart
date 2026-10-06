import 'base/indian_input_formatter.dart';

/// Formats Indian currency amounts as the user types.
///
/// - Optionally shows the `₹` symbol.
/// - Groups digits using the Indian numbering system:
///   last three digits, then pairs moving left.
/// - Handles up to [decimalPlaces] decimal digits.
///
/// Example: `1234567.5` becomes `₹12,34,567.5`.
class IndianCurrencyInputFormatter extends IndianInputFormatter {
  /// Creates an [IndianCurrencyInputFormatter].
  ///
  /// Set [showSymbol] to false to hide the `₹` prefix.
  /// Set [decimalPlaces] to 0 for integers only.
  const IndianCurrencyInputFormatter({
    this.showSymbol = true,
    this.decimalPlaces = 2,
  });

  /// Whether the `₹` symbol is shown.
  final bool showSymbol;

  /// Maximum number of digits after the decimal point.
  final int decimalPlaces;

  @override
  String strip(String input) {
    final cleaned = input.replaceAll(RegExp(r'[^\d.]'), '');
    // Keep only the first decimal point.
    final firstDot = cleaned.indexOf('.');
    if (firstDot == -1) return cleaned;
    return cleaned.substring(0, firstDot + 1) +
        cleaned.substring(firstDot + 1).replaceAll('.', '');
  }

  @override
  String format(String raw) {
    if (raw.isEmpty) return '';

    final parts = raw.split('.');
    final intPart = parts[0];
    final decPart = parts.length > 1 ? parts[1] : '';
    final hasDecimal = raw.contains('.');

    final grouped = _groupIndian(intPart);
    final symbol = showSymbol ? '₹' : '';

    if (hasDecimal) {
      final truncated = decPart.length > decimalPlaces
          ? decPart.substring(0, decimalPlaces)
          : decPart;
      return '$symbol$grouped.$truncated';
    }
    return '$symbol$grouped';
  }

  String _groupIndian(String digits) {
    if (digits.length <= 3) return digits;

    final lastThree = digits.substring(digits.length - 3);
    final rest = digits.substring(0, digits.length - 3);

    final buffer = StringBuffer();
    for (int i = 0; i < rest.length; i++) {
      if (i > 0 && (rest.length - i) % 2 == 0) buffer.write(',');
      buffer.write(rest[i]);
    }
    buffer.write(',');
    buffer.write(lastThree);
    return buffer.toString();
  }

  @override
  bool isFormattingChar(String char) =>
      char == ',' || char == '₹' || char == '.';
}
