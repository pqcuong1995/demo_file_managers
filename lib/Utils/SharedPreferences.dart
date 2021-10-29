

import 'package:demo_file_manager/BLOC/login/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference{
  static Future<void> setTokenShared(String token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getTokenShared() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    return token;
  }

  static Future<void> deleteTokenShared(BuildContext context) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
  }

  static Future<void> onCheckTokenLocal(BuildContext context) async{
    String? token = await getTokenShared();
    if(token != null && token.isNotEmpty){
      return;
    }else{
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
    }
  }
}