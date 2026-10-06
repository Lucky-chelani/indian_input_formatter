import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indian_input_formatter/src/formatters/aadhar_input_formatter.dart';

import '../helpers/cursor_test_helper.dart';

void main() {
  const formatter = AadhaarInputFormatter();

  TextEditingValue value(String text, [int? cursor]) => TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(offset: cursor ?? text.length),
      );

  group('AadhaarInputFormatter — formatting', () {
    test('groups 12 digits as 4-4-4', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('123456789012'),
        expectedText: '1234 5678 9012',
        expectedCursor: 14,
      );
    });

    test('strips non-digits on paste', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('1234-5678-9012'),
        expectedText: '1234 5678 9012',
        expectedCursor: 14,
      );
    });

    test('truncates beyond 12 digits', () {
      expectFormatter(
        formatter: formatter,
        oldValue: TextEditingValue.empty,
        newValue: value('1234567890129999'),
        expectedText: '1234 5678 9012',
        expectedCursor: 14,
      );
    });
  });

  group('AadhaarInputFormatter — cursor behaviour', () {
    test('typing 5th digit inserts space and cursor stays after digit', () {
      expectFormatter(
        formatter: formatter,
        oldValue: value('1234'),
        newValue: value('12345'),
        expectedText: '1234 5',
        expectedCursor: 6,
      );
    });

    test('typing 9th digit inserts second space', () {
      expectFormatter(
        formatter: formatter,
        oldValue: value('1234 5678'),
        newValue: value('1234 56789'),
        expectedText: '1234 5678 9',
        expectedCursor: 11,
      );
    });

    test('insert in the middle keeps cursor logical', () {
      // "1234 5678 9012", cursor after "1234 " -> user types '9'
      expectFormatter(
        formatter: formatter,
        oldValue: value('1234 5678 9012', 5),
        newValue: value('1234 95678 9012', 6),
        expectedText: '1234 9567 8901', // truncated
        expectedCursor: 6,
      );
    });
  });
}
