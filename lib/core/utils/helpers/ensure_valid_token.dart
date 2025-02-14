import 'package:jwt_decoder/jwt_decoder.dart';

bool ensureValidToken(token) {
  if (!JwtDecoder.isExpired(token)) {
    return true;
  }
  return false;
}
