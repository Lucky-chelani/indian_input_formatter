import 'package:flutter/services.dart';

import 'cursor_mapper.dart';

/// Abstract base for all Indian input formatters.
///
/// Subclasses define three things:
///   1. [strip] — how to remove formatting characters from input
///   2. [format] — how to render raw data with formatting
///   3. [isFormattingChar] — which characters are "insignificant"
///
/// The base class handles the hard part: cursor position preservation.
abstract class IndianInputFormatter extends TextInputFormatter {
  /// Const constructor so subclasses can be `const`.
  const IndianInputFormatter();

  /// Removes every formatting character, leaving only significant data.
  ///
  /// Example: Aadhaar formatter's `strip('1234 5678 9012')` returns
  /// `'123456789012'`.
  String strip(String input);

  /// Applies formatting rules to raw data.
  ///
  /// Example: Aadhaar formatter's `format('123456789012')` returns
  /// `'1234 5678 9012'`.
  String format(String raw);

  /// Returns true if [char] is a formatting character.
  ///
  /// Formatting characters are inserted by the formatter and don't
  /// count toward the user's "significant" input count.
  bool isFormattingChar(String char);

  /// Optional fixed prefix that appears at the start of the formatted
  /// output (e.g. `'+91 '`). The cursor mapper skips these characters.
  ///
  /// Defaults to empty string.
  String get prefix => '';

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 1. Count significant characters before the cursor in the new text.
    final significantBefore = _countSignificantBefore(
      newValue.text,
      newValue.selection.baseOffset,
    );

    // 2. Strip and re-format.
    final raw = strip(newValue.text);
    final formatted = format(raw);

    // 3. Map cursor position back into the formatted string.
    final cursor = CursorMapper.map(
      formatted: formatted,
      significantCount: significantBefore,
      isFormattingChar: isFormattingChar,
      prefixLength:
          prefix.isNotEmpty && formatted.startsWith(prefix) ? prefix.length : 0,
    );

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursor),
    );
  }

  int _countSignificantBefore(String text, int offset) {
    final limit = offset.clamp(0, text.length);
    final start =
        (prefix.isNotEmpty && text.startsWith(prefix)) ? prefix.length : 0;
    int count = 0;
    for (int i = start; i < limit; i++) {
      if (!isFormattingChar(text[i])) count++;
    }
    return count;
  }
}
