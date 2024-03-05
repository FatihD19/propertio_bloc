part of 'send_message_bloc.dart';

sealed class SendMessageState extends Equatable {
  const SendMessageState();

  @override
  List<Object> get props => [];
}

final class SendMessageInitial extends SendMessageState {}

final class SendMessageLoading extends SendMessageState {}

final class SendMessageSuccess extends SendMessageState {}

final class SendMessageError extends SendMessageState {
  final String message;

  const SendMessageError(this.message);

  @override
  List<Object> get props => [message];
}
