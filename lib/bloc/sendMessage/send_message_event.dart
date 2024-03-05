part of 'send_message_bloc.dart';

sealed class SendMessageEvent extends Equatable {
  const SendMessageEvent();

  @override
  List<Object> get props => [];
}

class OnSendMessage extends SendMessageEvent {
  SendMessagePropertyRequestModel? sendMessageProperty;
  SendMessageProjectRequestModel? sendMessageProject;

  OnSendMessage({this.sendMessageProperty, this.sendMessageProject});

  @override
  List<Object> get props => [
        {sendMessageProperty, sendMessageProject}
      ];
}
