part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {
  bool? isRegistered;
  LoginInitial({this.isRegistered});

  LoginInitial updateState(){
    return LoginInitial();
  }

  LoginInitial updateStateCheckLogin(bool isRegistered){
    return LoginInitial(isRegistered: isRegistered);
  }

  @override
  List<Object?> get props =>[];
}
