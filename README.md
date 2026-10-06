# indian_input_formatters

Composable, cursor-safe Indian input formatters and validators for Flutter.

## Why

Format Indian data as users type — Aadhaar, PAN, GSTIN, IFSC, UPI, phone,
and INR currency. Cursor never jumps. Works with any `TextField`.

## Quick Start

\`\`\`dart
import 'package:indian_input_formatters/indian_input_formatters.dart';

TextFormField(
  inputFormatters: [AadhaarInputFormatter()],
  validator: IndianValidators.aadhaar,
)
\`\`\`

## Supported fields

| Field | Formatter | Validator |
|-------|-----------|-----------|
| Aadhaar | `AadhaarInputFormatter` | `IndianValidators.aadhaar` |
| PAN | `PanInputFormatter` | `IndianValidators.pan` |
| GSTIN | `GstinInputFormatter` | `IndianValidators.gstin` |
| IFSC | `IfscInputFormatter` | `IndianValidators.ifsc` |
| UPI ID | `UpiIdInputFormatter` | `IndianValidators.upi` |
| Mobile | `IndianPhoneInputFormatter` | `IndianValidators.phone` |
| PIN | `PincodeInputFormatter` | `IndianValidators.pincode` |
| Currency | `IndianCurrencyInputFormatter` | — |

## Cursor behaviour

Every formatter preserves cursor position across typing, backspacing,
pasting, and middle-insertion. See `test/cursor/` for the test matrix.

## License

MIT