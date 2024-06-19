import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_bloc/data/datasource/agent_remote_datasource.dart';

import 'package:propertio_bloc/data/model/responses/detail_agent_response_model.dart';

import 'package:propertio_bloc/data/model/responses/list_agent_response_model.dart';

part 'agent_event.dart';
part 'agent_state.dart';

class AgentBloc extends Bloc<AgentEvent, AgentState> {
  final AgentRemoteDataSource _agentRemoteDataSource;
  AgentBloc(this._agentRemoteDataSource) : super(AgentLoading()) {
    on<OnGetAgent>((event, emit) async {
      emit(AgentLoading());
      final result = await AgentRemoteDataSource()
          .getAgent(search: event.search, page: event.page);
      result.fold(
        (l) => emit(AgentError(l)),
        (r) => emit(AgentLoaded(r)),
      );
    });

    on<OnGetDetailAgent>((event, emit) async {
      emit(AgentLoading());
      final result = await AgentRemoteDataSource().getDetailAgent(event.id);
      result.fold(
        (l) => emit(AgentError(l)),
        (r) => emit(AgentDetailLoaded(r)),
      );
    });
  }
}
