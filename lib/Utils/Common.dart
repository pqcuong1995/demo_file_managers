
import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Common{
  static Future<String> bcryptEncodePassword(String password) async{
    final key = Key.fromUtf8("my 32 length key................");
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final String code = encrypter.encrypt(password,iv: iv).base64;
    return code;
  }

  static Future<bool> verifyPassword(String password, String input) async{
    final key = Key.fromUtf8("my 32 length key................");
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    if(encrypter.decrypt64(password, iv: iv) == input){
      return true;
    }
    return false;
  }


}