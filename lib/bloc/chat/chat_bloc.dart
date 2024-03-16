import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_mobile/data/datasource/chat_remote_datasource.dart';
import 'package:propertio_mobile/data/model/responses/list_chat_response_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRemoteDataSource chatRemoteDataSource;
  ChatBloc(this.chatRemoteDataSource) : super(ChatInitial()) {
    on<OnGetListChat>((event, emit) async {
      emit(ChatLoading());
      final result = await chatRemoteDataSource.getListChat(event.id);
      result.fold(
        (l) => emit(ChatError(l)),
        (r) => emit(ChatLoaded(r)),
      );
    });
  }
}
