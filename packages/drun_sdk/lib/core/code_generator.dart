import 'dart:math';

import 'package:ulid/ulid.dart';

class CodeGenerator {
  static const String letters =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  static const String allowedChars = '0123456789$letters';
  static const int numberOfCodePoints = allowedChars.length;
  static const int codeSize = 11;

  /// Generates a UID according to the following rules:
  /// - Alphanumeric characters only.
  /// - Exactly 11 characters long.
  /// - First character is alphabetic.
  static String generateUid() {
    return generateCode(codeSize);
  }

  static String generateUlid() {
    return Ulid().toCanonical();
  }

  /// Generates a pseudo random string with alphanumeric characters.
  ///
  /// The [codeSize] parameter specifies the number of characters in the code.
  static String generateCode(int codeSize) {
    final random = Random();
    final randomChars = List.generate(codeSize, (i) {
      return i == 0
          ? letters[random.nextInt(letters.length)]
          : allowedChars[random.nextInt(numberOfCodePoints)];
    });

    return randomChars.join();
  }
}
