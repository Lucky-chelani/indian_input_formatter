import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indian_input_formatter/src/formatters/pan_input_formatter.dart';

import '../helpers/cursor_test_helper.dart';

void main() {
  const formatter = PanInputFormatter();

  TextEditingValue value(String text, [int? cursor]) => TextEditingValue(
    text: text,
    selection: TextSelection.collapsed(offset: cursor ?? text.length),
  );

  group('PanInputFormatter', () {
    test('uppercases lowercase input', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('abcde1234f'),
        expectedText: 'ABCDE1234F',
        expectedCursor: 10,
      );
    });

    test('strips non-alphanumeric characters', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('abc-de 1234_f'),
        expectedText: 'ABCDE1234F',
        expectedCursor: 10,
      );
    });

    test('truncates to 10 characters', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('ABCDE1234FEXTRA'),
        expectedText: 'ABCDE1234F',
        expectedCursor: 10,
      );
    });

    test('typing one char at a time keeps cursor at end', () {
      expectFormatter(
        formatter: formatter,
        oldValue: value('A'),
        newValue: value('AB'),
        expectedText: 'AB',
        expectedCursor: 2,
      );
    });

    test('backspace removes last char', () {
      expectFormatter(
        formatter: formatter,
        oldValue: value('ABC'),
        newValue: value('AB'),
        expectedText: 'AB',
        expectedCursor: 2,
      );
    });
  });
}
