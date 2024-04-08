import 'dart:convert';

import 'package:crypto/crypto.dart';

abstract class PasswordHash {
  static String hash(String password) {
    return sha512.convert(utf8.encode(password)).toString();
  }

  static bool compare(String password, String passwordHash) {
    return passwordHash == hash(password);
  }
}
