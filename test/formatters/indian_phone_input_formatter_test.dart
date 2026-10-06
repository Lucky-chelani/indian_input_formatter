import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indian_input_formatter/src/formatters/indian_phone_input_formatter.dart';

import '../helpers/cursor_test_helper.dart';

void main() {
  const formatter = IndianPhoneInputFormatter();

  TextEditingValue value(String text, [int? cursor]) => TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: cursor ?? text.length),
      );

  group('IndianPhoneInputFormatter', () {
    test('first digit adds +91 prefix', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('9'),
        expectedText: '+91 9',
        expectedCursor: 5,
      );
    });

    test('typing second digit keeps cursor at end', () {
      expectFormatter(
        formatter: formatter,
        oldValue: value('+91 9'),
        newValue: value('+91 98'),
        expectedText: '+91 98',
        expectedCursor: 6,
      );
    });

    test('10 digits grouped as +91 5+5', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('9876543210'),
        expectedText: '+91 98765 43210',
        expectedCursor: 15,
      );
    });

    test('paste of +919876543210 works', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('+919876543210'),
        expectedText: '+91 98765 43210',
        expectedCursor: 15,
      );
    });

    test('paste of 09876543210 strips leading zero', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('09876543210'),
        expectedText: '+91 98765 43210',
        expectedCursor: 15,
      );
    });

    test('paste of 919876543210 strips 91', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('919876543210'),
        expectedText: '+91 98765 43210',
        expectedCursor: 15,
      );
    });

    test('backspace from full number removes last digit', () {
      expectFormatter(
        formatter: formatter,
        oldValue: value('+91 98765 43210'),
        newValue: value('+91 98765 4321'),
        expectedText: '+91 98765 4321',
        expectedCursor: 14,
      );
    });
  });
}
