import 'base/indian_input_formatter.dart';

/// Restricts input to a 6-digit Indian PIN code.
class PincodeInputFormatter extends IndianInputFormatter {
  /// Creates a [PincodeInputFormatter].
  const PincodeInputFormatter();

  @override
  String strip(String input) => input.replaceAll(RegExp(r'\D'), '');

  @override
  String format(String raw) => raw.length > 6 ? raw.substring(0, 6) : raw;

  @override
  bool isFormattingChar(String char) => false;
}
