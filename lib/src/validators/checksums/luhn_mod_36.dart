/// Luhn mod 36 checksum used by GSTIN's 15th character.
class LuhnMod36 {
  LuhnMod36._();

  static const String _alphabet = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  /// Returns true if [code] passes the official Indian GSTIN mod 36 checksum.
  static bool validate(String code) {
    final input = code.toUpperCase();
    if (input.length != 15) return false;
    const n = _alphabet.length;
    int total = 0;

    for (int i = 0; i < 14; i++) {
      final codePoint = _alphabet.indexOf(input[i]);
      if (codePoint == -1) return false;

      final factor = (i % 2 != 0) ? 2 : 1;
      final product = codePoint * factor;
      total += (product ~/ n) + (product % n);
    }

    final checkCode = (n - (total % n)) % n;
    return _alphabet[checkCode] == input[14];
  }
}
