import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;

const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
const publicKey = 'e0c9de1b2de26fe2';




dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
  final keyObj = encrypt.Key.fromUtf8(privateKey);
  final ivObj = encrypt.IV.fromUtf8(publicKey);
  final encrypter = encrypt.Encrypter(encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));

  try {
    final decrypted = encrypter.decrypt(encrypt.Encrypted.fromBase64(encryptedText), iv: ivObj);
    return decrypted;
  } catch (e) {
    return 'Error....................';
  }
}
String encryptData(Map<String,dynamic> data, String privateKey, String publicKey) {
  final key = encrypt.Key.fromUtf8(privateKey);
  final iv = encrypt.IV.fromUtf8(publicKey);
  final encrypter = encrypt.Encrypter(
    encrypt.AES(key, mode: encrypt.AESMode.cbc),
  );
  try{
    String jsonString = json.encode(data);
    final encrypted = encrypter.encrypt(jsonString, iv: iv);
    final encryptedText = encrypted.base64;
    return encryptedText;
  }
  catch(e){
    return 'Error....................';
  }

}
