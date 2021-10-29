import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:demo_file_manager/BLOC/home/DriverScreen.dart';
import 'package:demo_file_manager/Utils/Common.dart';
import 'package:demo_file_manager/Utils/SharedPreferences.dart';
import 'package:demo_file_manager/model/User.dart';
import 'package:demo_file_manager/repository/MyRepository.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginInitial> {
  final MyRepository? repository;
  final BuildContext? context;
   String? password = "";
   String? confirmPassword = "";
   bool isRegistered = false;
  LoginBloc({this.repository, this.context}) : super(LoginInitial(isRegistered: false)) {
    on<LoginEvent>((event, emit) async {
      if(event is OnCheckLogin){
        List<User>? users = await repository!.getAllUser();
        var len = users?.length ?? 0;
        if(len !=0 ){
          isRegistered = true;
          emit.call(state.updateStateCheckLogin(isRegistered));
        }
      }

      if (event is OnLoginEvent) {
        List<User>? users = await repository!.getAllUser();
        if(users!.length != 0){
          if(password == null){
            return;
          }
          bool isSuccess = await Common.verifyPassword(users[0].password!, password!);
          if(isSuccess){
            SharedPreference.setTokenShared(await Common.bcryptEncodePassword(password!));
            Navigator.of(context!).push(MaterialPageRoute(builder: (context) =>MyHomePage(),));
          }
        }
      }

      if (event is OnRegisterEvent) {
        if(password == "" || confirmPassword == "" || confirmPassword != password){
          return;
        }
        String passEncode = await Common.bcryptEncodePassword(password!);
        User user = User(password: passEncode);
        repository!.savePassword(user);
        SharedPreference.setTokenShared(passEncode);
        Navigator.of(context!).push(MaterialPageRoute(builder: (context) =>MyHomePage(),));
      }

      if (event is OnChangePassword) {
        if (event.password != null) {
          password = event.password;
        }
        if (event.confirmPassword != null) {
          confirmPassword = event.confirmPassword;
        }
      }
    });
  }
}
