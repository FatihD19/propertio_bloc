part of 'agent_bloc.dart';

sealed class AgentEvent extends Equatable {
  const AgentEvent();

  @override
  List<Object> get props => [];
}

class OnGetAgent extends AgentEvent {
  String? search;
  int? page;

  OnGetAgent({this.search, this.page});

  @override
  List<Object> get props => [
        {search, page}
      ];
}

class OnGetDetailAgent extends AgentEvent {
  final String id;

  const OnGetDetailAgent(this.id);

  @override
  List<Object> get props => [id];
}
