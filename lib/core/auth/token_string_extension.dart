import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

extension TokenStringExtension on String? {
  bool get isAccessTokenValid {
    return true;
    if (this == null) {
      return false;
    }

    final JWT? decodedJwt = JWT.tryDecode(this!);
    if (decodedJwt == null) return false;

    final expirationDateTime =
    DateTime.fromMillisecondsSinceEpoch(decodedJwt.payload['exp'] * 1000);

    return DateTime.now()
        .add(const Duration(milliseconds: 1000)) // Safety margin
        .isBefore(expirationDateTime);
  }

  DateTime? get expirationTime {
    if (this == null) {
      return null;
    }

    final JWT? decodedJwt = JWT.tryDecode(this!);
    if (decodedJwt == null) return null;

    try {
      final expirationDateTime =
      DateTime.fromMillisecondsSinceEpoch(decodedJwt.payload['exp'] * 1000);
      return expirationDateTime;
    } catch (e) {
      return null;
    }
  }
}
