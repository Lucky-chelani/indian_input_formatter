import 'base/indian_input_formatter.dart';

/// Formats Aadhaar input as the user types.
///
/// - Keeps only digits.
/// - Limits input to 12 digits.
/// - Groups digits in blocks of 4 with spaces: `1234 5678 9012`.
class AadhaarInputFormatter extends IndianInputFormatter {
  /// Creates an [AadhaarInputFormatter].
  const AadhaarInputFormatter();

  static const int _maxLength = 12;
  static const int _groupSize = 4;

  @override
  String strip(String input) => input.replaceAll(RegExp(r'\D'), '');

  @override
  String format(String raw) {
    final digits = raw.length > _maxLength ? raw.substring(0, _maxLength) : raw;
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % _groupSize == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  @override
  bool isFormattingChar(String char) => char == ' ';
}
