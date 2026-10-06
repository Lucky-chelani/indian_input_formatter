/// Utility that maps a "significant character count" back into a real
/// cursor offset within a formatted string.
class CursorMapper {
  CursorMapper._();

  /// Maps a significant-character count to a cursor offset.
  ///
  /// The package's core idea: users type *significant* characters
  /// (digits, letters). Formatters insert *insignificant* characters
  /// (spaces, commas, symbols). When mapping the cursor, we count
  /// significant characters only, then find the offset just after the
  /// Nth significant character in the formatted output.
  ///
  /// [formatted] is the fully-formatted output.
  /// [significantCount] is the number of significant characters that
  ///   should appear before the cursor.
  /// [isFormattingChar] returns true for characters that don't count
  ///   as significant (spaces, commas, symbols).
  /// [prefixLength] is the number of leading characters in [formatted]
  ///   that belong to a fixed prefix (e.g. "+91 ") and should be skipped.
  static int map({
    required String formatted,
    required int significantCount,
    required bool Function(String) isFormattingChar,
    int prefixLength = 0,
  }) {
    if (formatted.isEmpty) return 0;

    // Skip the prefix only if the formatted string actually starts with it.
    final start = formatted.length >= prefixLength ? prefixLength : 0;

    if (significantCount == 0) return start;

    int seen = 0;
    for (int i = start; i < formatted.length; i++) {
      if (!isFormattingChar(formatted[i])) {
        seen++;
        if (seen == significantCount) return i + 1;
      }
    }

    return formatted.length;
  }
}
