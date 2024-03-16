part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class OnGetListChat extends ChatEvent {
  String id;

  OnGetListChat(this.id);

  @override
  List<Object> get props => [id];
}
