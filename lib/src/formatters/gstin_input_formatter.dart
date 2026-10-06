import 'base/indian_input_formatter.dart';

/// Formats GSTIN as the user types.
///
/// - Uppercases letters.
/// - Keeps only alphanumerics.
/// - Limits to 15 characters.
class GstinInputFormatter extends IndianInputFormatter {
  /// Creates a [GstinInputFormatter].
  const GstinInputFormatter();

  @override
  String strip(String input) =>
      input.replaceAll(RegExp(r'[^A-Za-z0-9]'), '').toUpperCase();

  @override
  String format(String raw) => raw.length > 15 ? raw.substring(0, 15) : raw;

  @override
  bool isFormattingChar(String char) => false;
}
