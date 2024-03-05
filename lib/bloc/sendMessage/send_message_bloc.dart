import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_mobile/data/datasource/send_message_remote_datasource.dart';
import 'package:propertio_mobile/data/model/request/send_message_request_model.dart';

part 'send_message_event.dart';
part 'send_message_state.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  final SendMessageRemoteDataSource _sendMessageRemoteDataSource;
  SendMessageBloc(this._sendMessageRemoteDataSource)
      : super(SendMessageInitial()) {
    on<OnSendMessage>((event, emit) async {
      emit(SendMessageLoading());
      final result = await _sendMessageRemoteDataSource.sendMessage(
          property: event.sendMessageProperty,
          project: event.sendMessageProject);
      if (result) {
        emit(SendMessageSuccess());
      } else {
        emit(SendMessageError('Failed to send message. Please try again.'));
      }
    });
  }
}
