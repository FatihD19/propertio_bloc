part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFailed extends AuthState {
  final String message;

  const AuthFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class AuthSuccess extends AuthState {
  final LoginResponseModel user;

  const AuthSuccess(this.user);

  @override
  List<Object> get props => [user];
}
