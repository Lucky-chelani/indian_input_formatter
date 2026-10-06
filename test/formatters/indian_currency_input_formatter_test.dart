import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indian_input_formatter/src/formatters/indian_currency_input_formatter.dart';

import '../helpers/cursor_test_helper.dart';

void main() {
  const formatter = IndianCurrencyInputFormatter();

  TextEditingValue value(String text, [int? cursor]) => TextEditingValue(
    text: text,
    selection: TextSelection.collapsed(offset: cursor ?? text.length),
  );

  group('IndianCurrencyInputFormatter — Indian grouping', () {
    test('4 digits -> 1,234', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('1234'),
        expectedText: '₹1,234',
        expectedCursor: 6,
      );
    });

    test('5 digits -> 12,345', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('12345'),
        expectedText: '₹12,345',
        expectedCursor: 7,
      );
    });

    test('6 digits -> 1,23,456', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('123456'),
        expectedText: '₹1,23,456',
        expectedCursor: 9,
      );
    });

    test('8 digits -> 1,23,45,678', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('12345678'),
        expectedText: '₹1,23,45,678',
        expectedCursor: 12,
      );
    });
  });

  group('IndianCurrencyInputFormatter — decimals', () {
    test('decimal point preserved', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('1234.5'),
        expectedText: '₹1,234.5',
        expectedCursor: 8,
      );
    });

    test('decimal digits capped at 2', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('1234.5678'),
        expectedText: '₹1,234.56',
        expectedCursor: 9,
      );
    });

    test('only first decimal point kept', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('12.3.4'),
        expectedText: '₹12.34',
        expectedCursor: 6,
      );
    });
  });

  group('IndianCurrencyInputFormatter — options', () {
    test('showSymbol=false omits rupee symbol', () {
      const noSymbol = IndianCurrencyInputFormatter(showSymbol: false);
      expectFormatter(
        formatter: noSymbol,
        oldValue: TextEditingValue.empty,
        newValue: value('123456'),
        expectedText: '1,23,456',
        expectedCursor: 8,
      );
    });

    test('decimalPlaces=0 strips decimals', () {
      const noDecimals = IndianCurrencyInputFormatter(decimalPlaces: 0);
      expectFormatter(
        formatter: noDecimals,
        oldValue: TextEditingValue.empty,
        newValue: value('1234.56'),
        expectedText: '₹1,234.',
        expectedCursor: 7,
      );
    });
  });
}
