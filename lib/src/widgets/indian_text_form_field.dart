import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indian_input_formatter/indian_input_formatter.dart';


/// Preset field types for [IndianTextFormField].
enum IndianFieldType {
  /// Aadhaar number field.
  aadhaar,

  /// PAN card field.
  pan,

  /// GSTIN field.
  gstin,

  /// IFSC code field.
  ifsc,

  /// UPI ID field.
  upi,

  /// Indian mobile number field.
  phone,

  /// Indian PIN code field.
  pincode,

  /// Indian currency amount field.
  currency,
}

/// A convenience [TextFormField] preconfigured with the correct
/// formatter, validator, keyboard type, and label for the given
/// [IndianFieldType].
class IndianTextFormField extends StatelessWidget {
  /// Creates an [IndianTextFormField].
  const IndianTextFormField({
    super.key,
    required this.type,
    this.label,
    this.onChanged,
    this.controller,
    this.initialValue,
  });

  /// The type of Indian data this field collects.
  final IndianFieldType type;

  /// Optional override for the default label.
  final String? label;

  /// Called whenever the field value changes.
  final ValueChanged<String>? onChanged;

  /// Optional controller.
  final TextEditingController? controller;

  /// Optional initial value.
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      decoration: InputDecoration(labelText: label ?? _defaultLabel),
      keyboardType: _keyboardType,
      inputFormatters: <TextInputFormatter>[_formatter],
      validator: _validator,
      onChanged: onChanged,
    );
  }

  TextInputFormatter get _formatter => switch (type) {
    IndianFieldType.aadhaar => const AadhaarInputFormatter(),
    IndianFieldType.pan => const PanInputFormatter(),
    IndianFieldType.gstin => const GstinInputFormatter(),
    IndianFieldType.ifsc => const IfscInputFormatter(),
    IndianFieldType.upi => const UpiIdInputFormatter(),
    IndianFieldType.phone => const IndianPhoneInputFormatter(),
    IndianFieldType.pincode => const PincodeInputFormatter(),
    IndianFieldType.currency => const IndianCurrencyInputFormatter(),
  };

  String? Function(String?) get _validator => switch (type) {
    IndianFieldType.aadhaar => IndianValidators.aadhaar,
    IndianFieldType.pan => IndianValidators.pan,
    IndianFieldType.gstin => IndianValidators.gstin,
    IndianFieldType.ifsc => IndianValidators.ifsc,
    IndianFieldType.upi => IndianValidators.upi,
    IndianFieldType.phone => IndianValidators.phone,
    IndianFieldType.pincode => IndianValidators.pincode,
    IndianFieldType.currency => (_) => null,
  };

  TextInputType get _keyboardType => switch (type) {
    IndianFieldType.aadhaar ||
    IndianFieldType.phone ||
    IndianFieldType.pincode ||
    IndianFieldType.currency => TextInputType.number,
    _ => TextInputType.text,
  };

  String get _defaultLabel => switch (type) {
    IndianFieldType.aadhaar => 'Aadhaar Number',
    IndianFieldType.pan => 'PAN',
    IndianFieldType.gstin => 'GSTIN',
    IndianFieldType.ifsc => 'IFSC Code',
    IndianFieldType.upi => 'UPI ID',
    IndianFieldType.phone => 'Mobile Number',
    IndianFieldType.pincode => 'PIN Code',
    IndianFieldType.currency => 'Amount',
  };
}
