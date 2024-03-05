part of 'developer_bloc.dart';

sealed class DeveloperState extends Equatable {
  const DeveloperState();

  @override
  List<Object> get props => [];
}

final class DeveloperInitial extends DeveloperState {}

final class DeveloperLoading extends DeveloperState {}

final class DeveloperLoaded extends DeveloperState {
  final DetailDeveloperResponseModel detail;

  DeveloperLoaded(this.detail);

  @override
  List<Object> get props => [detail];
}

final class ProjectDeveloperLoaded extends DeveloperState {
  final ListProjects projects;

  ProjectDeveloperLoaded(this.projects);

  @override
  List<Object> get props => [projects];
}

final class DeveloperError extends DeveloperState {
  final String message;

  DeveloperError(this.message);

  @override
  List<Object> get props => [message];
}
