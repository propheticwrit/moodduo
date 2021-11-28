part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccessful extends LoginState {
  final User currentUser;

  LoginSuccessful({required this.currentUser});
}

class LoginFailed extends LoginState {
  final String errMessage;

  LoginFailed({required this.errMessage});
}
