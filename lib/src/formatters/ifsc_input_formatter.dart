import 'base/indian_input_formatter.dart';

/// Formats IFSC codes as the user types.
///
/// - Uppercases letters.
/// - Keeps only alphanumerics.
/// - Limits to 11 characters.
class IfscInputFormatter extends IndianInputFormatter {
  /// Creates an [IfscInputFormatter].
  const IfscInputFormatter();

  @override
  String strip(String input) =>
      input.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toUpperCase();

  @override
  String format(String raw) => raw.length > 11 ? raw.substring(0, 11) : raw;

  @override
  bool isFormattingChar(String char) => false;
}
