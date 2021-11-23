import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:encrypt/encrypt.dart';

String encrypts(String plainText) {
  final key = encrypt.Key.fromUtf8('my 32 length key................');
  final iv = encrypt.IV.fromLength(16);

  final encrypter = encrypt.Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);

  return encrypted.base64;
}
