import 'base/indian_input_formatter.dart';

/// Formats PAN input as the user types.
///
/// - Auto-uppercases all letters.
/// - Removes non-alphanumeric characters.
/// - Limits input to 10 characters.
///
/// Example: `abcde1234f` becomes `ABCDE1234F`.
class PanInputFormatter extends IndianInputFormatter {
  /// Creates a [PanInputFormatter].
  const PanInputFormatter();

  @override
  String strip(String input) =>
      input.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toUpperCase();

  @override
  String format(String raw) => raw.length > 10 ? raw.substring(0, 10) : raw;

  @override
  bool isFormattingChar(String char) => false;
}
