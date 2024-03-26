part of 'reset_password_cubit.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordLoading extends ResetPasswordState {}

final class ResetPasswordSuccess extends ResetPasswordState {
  final String message;
  const ResetPasswordSuccess(this.message);
  @override
  List<Object> get props => [message];
}

final class ResetPasswordError extends ResetPasswordState {
  final String message;
  const ResetPasswordError(this.message);
  @override
  List<Object> get props => [message];
}