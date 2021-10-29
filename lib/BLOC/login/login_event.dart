part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class OnCheckLogin extends LoginEvent{
  OnCheckLogin();
  @override
  List<Object?> get props => [];
}

class OnLoginEvent extends LoginEvent{

  final String? password;
  OnLoginEvent({this.password});

  @override
  List<Object?> get props => [password];
}

class OnRegisterEvent extends LoginEvent{
  OnRegisterEvent();
  @override
  List<Object?> get props => [];
}

class OnChangePassword extends LoginEvent{
  final String? password;
  final String? confirmPassword;

  OnChangePassword({this.password, this.confirmPassword});

  @override
  List<Object?> get props => [password, confirmPassword];
}