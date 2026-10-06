/// Luhn mod 36 checksum used by GSTIN's 15th character.
class LuhnMod36 {
  LuhnMod36._();

  static const String _alphabet = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  /// Returns true if [code] passes the Luhn mod 36 checksum.
  static bool validate(String code) {
    final input = code.toUpperCase();
    const n = _alphabet.length;
    int factor = 2;
    int sum = 0;

    for (int i = input.length - 1; i >= 0; i--) {
      final codePoint = _alphabet.indexOf(input[i]);
      if (codePoint == -1) return false;

      int addend = factor * codePoint;
      factor = factor == 2 ? 1 : 2;
      addend = (addend ~/ n) + (addend % n);
      sum += addend;
    }
    return sum % n == 0;
  }
}
