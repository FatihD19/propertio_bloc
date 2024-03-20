part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLogin extends AuthEvent {
  final LoginRequestModel data;
  const AuthLogin(this.data);

  @override
  List<Object> get props => [data];
}

class AuthGetCurrentUser extends AuthEvent {}

class RegisterUser extends AuthEvent {
  final RegisterRequestModel data;
  const RegisterUser(this.data);

  @override
  List<Object> get props => [data];
}
