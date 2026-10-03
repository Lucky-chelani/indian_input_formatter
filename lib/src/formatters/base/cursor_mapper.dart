import 'package:flutter/widgets.dart';

class CursorMapper {
  CursorMapper._();

  static int map({
    required String formatted,
    required int significantCount,
    required bool Function(String) isFormattingChar,
    int prefixLength =0,
  }) {
    if(formatted.isEmpty) return 0;

    final start = formatted.length >= prefixLength ? prefixLength : 0;

    if(significantCount == 0 ) return start;

    int seen = 0 ;
    for(int i = start;i<formatted.length;i++){
      if(!isFormattingChar(formatted[i])){
        seen++;
        if(seen == significantCount) return i+1;
      }
    }

    return formatted.length;
  }
}