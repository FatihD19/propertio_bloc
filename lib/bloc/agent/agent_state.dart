part of 'agent_bloc.dart';

sealed class AgentState extends Equatable {
  const AgentState();

  @override
  List<Object> get props => [];
}

final class AgentInitial extends AgentState {}

final class AgentLoading extends AgentState {}

final class AgentLoaded extends AgentState {
  final ListAgentModel listAgentModel;

  const AgentLoaded(this.listAgentModel);

  @override
  List<Object> get props => [listAgentModel];
}

final class AgentDetailLoaded extends AgentState {
  final DetailAgentResponseModel agentModel;

  const AgentDetailLoaded(this.agentModel);

  @override
  List<Object> get props => [agentModel];
}

final class AgentError extends AgentState {
  final String message;

  const AgentError(this.message);

  @override
  List<Object> get props => [message];
}
