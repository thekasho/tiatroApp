part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserModel user;
  final Map userInfo;

  AuthSuccess(this.user, this.userInfo);
}

class AuthFailed extends AuthState {
  final String message;

  AuthFailed(this.message);
}
