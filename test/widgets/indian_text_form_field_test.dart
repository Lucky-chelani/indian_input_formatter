import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indian_input_formatter/indian_input_formatter.dart';

void main() {
  testWidgets(
      'IndianTextFormField renders with default label and formats input', (
    tester,
  ) async {
    final formKey = GlobalKey<FormState>();
    final controller = TextEditingController();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: IndianTextFormField(
              type: IndianFieldType.aadhaar,
              controller: controller,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Aadhaar Number'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '123456789012');
    await tester.pump();

    expect(controller.text, '1234 5678 9012');

    final isValid = formKey.currentState?.validate();
    expect(isValid, isFalse); // invalid checksum
  });

  testWidgets(
      'IndianTextFormField respects custom label and validator override', (
    tester,
  ) async {
    final formKey = GlobalKey<FormState>();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            key: formKey,
            child: IndianTextFormField(
              type: IndianFieldType.pan,
              label: 'Custom PAN Label',
              validator: (val) => val == 'TEST' ? null : 'Must be TEST',
            ),
          ),
        ),
      ),
    );

    expect(find.text('Custom PAN Label'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'TEST');
    await tester.pump();

    final isValid = formKey.currentState?.validate();
    expect(isValid, isTrue);
  });
}
