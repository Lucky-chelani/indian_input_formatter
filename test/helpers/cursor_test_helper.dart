

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Runs a formatter against the given old/new values and asserts both
/// the resulting text and the resulting cursor offset.
void expectFormatter({
  required TextInputFormatter formatter,
  required TextEditingValue oldValue,
  required TextEditingValue newValue,
  required String expectedText,
  required int expectedCursor,
}){
  final result = formatter.formatEditUpdate(oldValue, newValue);
  expect(result.text,expectedText,reason: 'Text Mismatch');
    expect(
    result.selection.baseOffset,
    expectedCursor,
    reason: 'cursor mismatch',
  );
}