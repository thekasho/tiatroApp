part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthRegister extends AuthEvent {
  final String username;
  final String password;
  final String domain;
  final String mac;
  final String id;

  AuthRegister(this.username, this.password, this.domain, this.mac, this.id);
}

class AuthGetUser extends AuthEvent {}

class AuthLogOut extends AuthEvent {}
