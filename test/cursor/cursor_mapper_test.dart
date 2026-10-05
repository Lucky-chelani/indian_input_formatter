import 'package:flutter_test/flutter_test.dart';
import 'package:indian_input_formatter/src/formatters/base/cursor_mapper.dart';


void main() {
  bool isSpace(String c) => c == ' ';

  group('CursorMapper.map', () {
    test('empty string returns 0', () {
      expect(
        CursorMapper.map(
          formatted: '',
          significantCount: 0,
          isFormattingChar: isSpace,
        ),
        0,
      );
    });

    test('zero significant returns 0 (no prefix)', () {
      expect(
        CursorMapper.map(
          formatted: '1234',
          significantCount: 0,
          isFormattingChar: isSpace,
        ),
        0,
      );
    });

    test('1 significant in "1234" returns offset 1', () {
      expect(
        CursorMapper.map(
          formatted: '1234',
          significantCount: 1,
          isFormattingChar: isSpace,
        ),
        1,
      );
    });

    test('skips space when counting', () {
      // "1234 5" -> significantCount=5 -> offset 6
      expect(
        CursorMapper.map(
          formatted: '1234 5',
          significantCount: 5,
          isFormattingChar: isSpace,
        ),
        6,
      );
    });

    test('full 12 digits in "1234 5678 9012" returns offset 14', () {
      expect(
        CursorMapper.map(
          formatted: '1234 5678 9012',
          significantCount: 12,
          isFormattingChar: isSpace,
        ),
        14,
      );
    });

    test('prefix is skipped', () {
      // "+91 9" with prefixLength=4 -> significantCount=1 -> offset 5
      expect(
        CursorMapper.map(
          formatted: '+91 9',
          significantCount: 1,
          isFormattingChar: isSpace,
          prefixLength: 4,
        ),
        5,
      );
    });

    test('count exceeding available significants returns length', () {
      expect(
        CursorMapper.map(
          formatted: '1234',
          significantCount: 99,
          isFormattingChar: isSpace,
        ),
        4,
      );
    });
  });
}