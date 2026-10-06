import 'package:flutter_test/flutter_test.dart';
import 'package:indian_input_formatter/src/validators/indian_validators.dart';

void main() {
  group('IndianValidators.pan', () {
    test('valid PAN passes', () {
      expect(IndianValidators.pan('ABCDE1234F'), isNull);
    });
    test('lowercase accepted after normalisation', () {
      expect(IndianValidators.pan('abcde1234f'), isNull);
    });
    test('wrong length rejected', () {
      expect(IndianValidators.pan('ABCDE1234'), isNotNull);
    });
    test('empty rejected', () {
      expect(IndianValidators.pan(''), isNotNull);
    });
  });

  group('IndianValidators.pincode', () {
    test(
      'valid pincode',
      () => expect(IndianValidators.pincode('560001'), isNull),
    );
    test(
      'leading zero rejected',
      () => expect(IndianValidators.pincode('060001'), isNotNull),
    );
    test(
      'too short rejected',
      () => expect(IndianValidators.pincode('56001'), isNotNull),
    );
  });

  group('IndianValidators.phone', () {
    test('valid 10-digit number', () {
      expect(IndianValidators.phone('9876543210'), isNull);
    });
    test('+91 prefix accepted', () {
      expect(IndianValidators.phone('+91 98765 43210'), isNull);
    });
    test('leading 0 accepted', () {
      expect(IndianValidators.phone('09876543210'), isNull);
    });
    test('starting with 5 rejected', () {
      expect(IndianValidators.phone('5876543210'), isNotNull);
    });
  });

  group('IndianValidators.ifsc', () {
    test(
      'valid IFSC',
      () => expect(IndianValidators.ifsc('HDFC0001234'), isNull),
    );
    test(
      'missing 0 rejected',
      () => expect(IndianValidators.ifsc('HDFC1001234'), isNotNull),
    );
  });

  group('IndianValidators.upi', () {
    test(
      'valid UPI',
      () => expect(IndianValidators.upi('user@okhdfcbank'), isNull),
    );
    test(
      'missing @ rejected',
      () => expect(IndianValidators.upi('userokhdfcbank'), isNotNull),
    );
  });

  group('IndianValidators.aadhaar', () {
    test('valid Aadhaar number passes', () {
      expect(IndianValidators.aadhaar('999999990019'), isNull);
      expect(IndianValidators.aadhaar('9999 9999 0019'), isNull);
    });
    test('wrong length rejected', () {
      expect(IndianValidators.aadhaar('12345678901'), isNotNull);
    });
    test('12 digits without valid checksum rejected', () {
      expect(IndianValidators.aadhaar('123456789012'), isNotNull);
    });
  });

  group('IndianValidators.gstin', () {
    test('valid GSTIN passes', () {
      expect(IndianValidators.gstin('27AAAPZ2318J1ZI'), isNull);
      expect(IndianValidators.gstin('27AAACT2727Q1ZW'), isNull);
    });
    test('wrong length rejected', () {
      expect(IndianValidators.gstin('27AABCU9603R1Z'), isNotNull);
    });
    test('malformed structure rejected', () {
      expect(IndianValidators.gstin('27AABCU9603R1ZM-extra'), isNotNull);
    });
    test('invalid checksum rejected', () {
      expect(IndianValidators.gstin('27AAAPZ2319J1ZI'), isNotNull);
    });
  });
}
