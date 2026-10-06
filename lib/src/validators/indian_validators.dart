import 'checksums/luhn_mod_36.dart';
import 'checksums/verhoeff.dart';

/// Validators for common Indian data formats.
///
/// Every method returns `null` if valid, or an error message string.
/// This matches Flutter's `FormFieldValidator` contract.
class IndianValidators {
  IndianValidators._();

  static final RegExp _panRegex = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');
  static final RegExp _gstinRegex = RegExp(
    r'^\d{2}[A-Z]{5}\d{4}[A-Z][1-9A-Z]Z[0-9A-Z]$',
  );
  static final RegExp _ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
  static final RegExp _upiRegex = RegExp(r'^[a-zA-Z0-9.\-_]{2,}@[a-zA-Z]{2,}$');
  static final RegExp _mobileRegex = RegExp(r'^[6-9]\d{9}$');
  static final RegExp _pincodeRegex = RegExp(r'^[1-9]\d{5}$');

  /// Validates an Aadhaar number (12 digits + Verhoeff checksum).
  static String? aadhaar(String? value) {
    if (value == null || value.trim().isEmpty) return 'Aadhaar is required';
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length != 12) return 'Aadhaar must be 12 digits';
    if (!Verhoeff.validate(digits)) return 'Invalid Aadhaar number';
    return null;
  }

  /// Validates a PAN card number.
  static String? pan(String? value) {
    if (value == null || value.trim().isEmpty) return 'PAN is required';
    if (!_panRegex.hasMatch(value.trim().toUpperCase())) {
      return 'Invalid PAN format';
    }
    return null;
  }

  /// Validates a GSTIN.
  static String? gstin(String? value) {
    if (value == null || value.trim().isEmpty) return 'GSTIN is required';
    final v = value.trim().toUpperCase();
    if (v.length != 15) return 'GSTIN must be 15 characters';
    if (!_gstinRegex.hasMatch(v)) return 'Invalid GSTIN format';
    if (!LuhnMod36.validate(v)) return 'Invalid GSTIN checksum';
    return null;
  }

  /// Validates an IFSC code.
  static String? ifsc(String? value) {
    if (value == null || value.trim().isEmpty) return 'IFSC is required';
    if (!_ifscRegex.hasMatch(value.trim().toUpperCase())) {
      return 'Invalid IFSC code';
    }
    return null;
  }

  /// Validates a UPI ID.
  static String? upi(String? value) {
    if (value == null || value.trim().isEmpty) return 'UPI ID is required';
    if (!_upiRegex.hasMatch(value.trim())) return 'Invalid UPI ID';
    return null;
  }

  /// Validates an Indian mobile number (10 digits starting 6-9).
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Phone is required';
    final digits = value.replaceAll(RegExp(r'\D'), '');
    String ten = digits;
    if (digits.length == 12 && digits.startsWith('91')) {
      ten = digits.substring(2);
    } else if (digits.length == 11 && digits.startsWith('0')) {
      ten = digits.substring(1);
    }
    if (ten.length != 10) return 'Phone must be 10 digits';
    if (!_mobileRegex.hasMatch(ten)) return 'Invalid Indian mobile number';
    return null;
  }

  /// Validates an Indian PIN code.
  static String? pincode(String? value) {
    if (value == null || value.trim().isEmpty) return 'PIN code is required';
    if (!_pincodeRegex.hasMatch(value.trim())) return 'Invalid PIN code';
    return null;
  }
}
