# indian_input_formatter

[![pub package](https://img.shields.io/pub/v/indian_input_formatter.svg)](https://pub.dev/packages/indian_input_formatter)
[![pub points](https://img.shields.io/pub/points/indian_input_formatter?color=2E8B57)](https://pub.dev/packages/indian_input_formatter/score)
[![license](https://img.shields.io/github/license/Lucky-chelani/indian_input_formatter.svg)](https://github.com/Lucky-chelani/indian_input_formatter/blob/main/LICENSE)

Production-grade, cursor-safe Indian input formatters and validators for Flutter.

Format Indian data as users type — **Aadhaar, PAN, GSTIN, IFSC, UPI, +91 Phone, PIN Code**, and **INR Currency** (lakhs & crores).

---

## Features

- 🎯 **Cursor-Safe**: Cursor position is preserved accurately during typing, middle insertions, deletions, and pasting.
- ⚡ **Zero External Dependencies**: Pure Flutter and Dart with zero third-party packages.
- 🛡️ **Mathematical Validation**: Official **Verhoeff checksum** for Aadhaar and official **Luhn Mod-36** algorithm for GSTIN.
- 🧩 **Drop-in Widget**: Preconfigured `IndianTextFormField` for instant form setup.
- 🌐 **Full Cross-Platform & WASM**: Supports Android, iOS, Web (including WASM), Windows, macOS, and Linux.

---

## Getting Started

Add `indian_input_formatter` to your `pubspec.yaml`:

```yaml
dependencies:
  indian_input_formatter: ^0.1.0
```

Import the package:

```dart
import 'package:indian_input_formatter/indian_input_formatter.dart';
```

---

## Supported Formatters & Validators

| Field | Formatter | Formatted Pattern | Validator |
| :--- | :--- | :--- | :--- |
| **Aadhaar** | `AadhaarInputFormatter()` | `1234 5678 9012` | `IndianValidators.aadhaar` (Verhoeff) |
| **PAN Card** | `PanInputFormatter()` | `ABCDE1234F` | `IndianValidators.pan` |
| **GSTIN** | `GstinInputFormatter()` | `27AAAPZ2318J1ZI` | `IndianValidators.gstin` (Mod-36) |
| **IFSC Code** | `IfscInputFormatter()` | `HDFC0001234` | `IndianValidators.ifsc` |
| **Mobile (+91)** | `IndianPhoneInputFormatter()` | `+91 98765 43210` | `IndianValidators.phone` |
| **PIN Code** | `PincodeInputFormatter()` | `560001` | `IndianValidators.pincode` |
| **UPI ID** | `UpiIdInputFormatter()` | `username@bank` | `IndianValidators.upi` |
| **INR Currency** | `IndianCurrencyInputFormatter()` | `₹12,34,567.50` | — |

---

## Usage Examples

### 1. Using `IndianTextFormField` (Simplest)

Use the built-in `IndianTextFormField` to quickly create preconfigured fields with appropriate formatters, validators, keyboard types, and labels:

```dart
// Aadhaar field
IndianTextFormField(
  type: IndianFieldType.aadhaar,
)

// Currency field (INR)
IndianTextFormField(
  type: IndianFieldType.currency,
)

// Mobile number field
IndianTextFormField(
  type: IndianFieldType.phone,
)
```

### 2. Using Formatters with Standard `TextFormField`

All formatters extend Flutter's `TextInputFormatter` and can be composed with any `TextField` or `TextFormField`:

#### Aadhaar Formatter
```dart
TextFormField(
  inputFormatters: const [AadhaarInputFormatter()],
  validator: IndianValidators.aadhaar,
  keyboardType: TextInputType.number,
  decoration: const InputDecoration(labelText: 'Aadhaar Number'),
)
```

#### Indian Currency Formatter (Lakh / Crore Grouping)
```dart
TextFormField(
  inputFormatters: const [
    IndianCurrencyInputFormatter(
      showSymbol: true, // Default: true (₹)
      decimalPlaces: 2, // Default: 2
    ),
  ],
  keyboardType: const TextInputType.numberWithOptions(decimal: true),
  decoration: const InputDecoration(labelText: 'Amount'),
)
```

#### Phone Formatter (+91 Prefix)
Automatically adds `+91 ` prefix and handles pasting of `+919876543210`, `09876543210`, or `9876543210`:
```dart
TextFormField(
  inputFormatters: const [IndianPhoneInputFormatter()],
  validator: IndianValidators.phone,
  keyboardType: TextInputType.phone,
  decoration: const InputDecoration(labelText: 'Mobile Number'),
)
```

#### GSTIN & PAN Formatters
Auto-uppercases input and limits characters:
```dart
TextFormField(
  inputFormatters: const [GstinInputFormatter()],
  validator: IndianValidators.gstin,
  decoration: const InputDecoration(labelText: 'GSTIN'),
)
```

---

## Standalone Validators

You can also use `IndianValidators` independently in your business logic or custom forms:

```dart
// Returns null if valid, or an error String if invalid:
String? error = IndianValidators.aadhaar('1234 5678 9012');
String? panError = IndianValidators.pan('ABCDE1234F');
String? gstinError = IndianValidators.gstin('27AAAPZ2318J1ZI');
```

---

## Example App

Check out the [`example/`](https://github.com/Lucky-chelani/indian_input_formatter/tree/main/example) directory for a complete Flutter application demonstrating all formatters and form validation in action.

---

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/Lucky-chelani/indian_input_formatter/blob/main/LICENSE) file for details.