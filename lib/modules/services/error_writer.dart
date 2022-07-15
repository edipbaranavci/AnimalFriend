import 'package:flutter/foundation.dart';

class ErrorWriter {
  static write<T>(dynamic e, T type) {
    if (kDebugMode) {
      print(e.toString());
      print(type);
    }
  }
}
