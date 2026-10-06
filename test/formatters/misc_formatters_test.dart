import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indian_input_formatter/src/formatters/gstin_input_formatter.dart';
import 'package:indian_input_formatter/src/formatters/ifsc_input_formatter.dart';
import 'package:indian_input_formatter/src/formatters/pincode_input_formatter.dart';
import 'package:indian_input_formatter/src/formatters/upi_id_formatter.dart';

import '../helpers/cursor_test_helper.dart';

void main() {
  TextEditingValue value(String text, [int? cursor]) => TextEditingValue(
    text: text,
    selection: TextSelection.collapsed(offset: cursor ?? text.length),
  );

  group('PincodeInputFormatter', () {
    const f = PincodeInputFormatter();

    test('limits to 6 digits', () {
      expectFormatter(
        formatter: f,
        oldValue: TextEditingValue.empty,
        newValue: value('12345678'),
        expectedText: '123456',
        expectedCursor: 6,
      );
    });

    test('strips non-digits', () {
      expectFormatter(
        formatter: f,
        oldValue: TextEditingValue.empty,
        newValue: value('56-78 90'),
        expectedText: '567890',
        expectedCursor: 6,
      );
    });
  });

  group('IfscInputFormatter', () {
    const f = IfscInputFormatter();

    test('uppercases and limits to 11', () {
      expectFormatter(
        formatter: f,
        oldValue: TextEditingValue.empty,
        newValue: value('hdfc0001234extra'),
        expectedText: 'HDFC0001234',
        expectedCursor: 11,
      );
    });
  });

  group('GstinInputFormatter', () {
    const f = GstinInputFormatter();

    test('uppercases and limits to 15', () {
      expectFormatter(
        formatter: f,
        oldValue: TextEditingValue.empty,
        newValue: value('27aabcu9603r1zm-extra'),
        expectedText: '27AABCU9603R1ZM',
        expectedCursor: 15,
      );
    });
  });

  group('UpiIdInputFormatter', () {
    const f = UpiIdInputFormatter();

    test('allows one @', () {
      expectFormatter(
        formatter: f,
        oldValue: TextEditingValue.empty,
        newValue: value('user@ok@hdfc'),
        expectedText: 'user@okhdfc',
        expectedCursor: 11,
      );
    });

    test('removes spaces', () {
      expectFormatter(
        formatter: f,
        oldValue: TextEditingValue.empty,
        newValue: value('user name@bank'),
        expectedText: 'username@bank',
        expectedCursor: 13,
      );
    });
  });
}
