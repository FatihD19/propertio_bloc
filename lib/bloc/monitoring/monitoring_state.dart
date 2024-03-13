part of 'monitoring_bloc.dart';

sealed class MonitoringState extends Equatable {
  const MonitoringState();

  @override
  List<Object> get props => [];
}

final class MonitoringInitial extends MonitoringState {}

final class MonitoringLoading extends MonitoringState {}

final class ProjectProgressLoaded extends MonitoringState {
  final ListProjectProgressResponseModel projectProgress;

  ProjectProgressLoaded(this.projectProgress);

  @override
  List<Object> get props => [projectProgress];
}

final class ProjectProgressPageLoaded extends MonitoringState {
  final ProgressProjectPageResponseModel projectProgress;

  ProjectProgressPageLoaded(this.projectProgress);

  @override
  List<Object> get props => [projectProgress];
}

final class DetailProjectProgressLoaded extends MonitoringState {
  final DetailProjectProgressResponseModel projectProgress;

  DetailProjectProgressLoaded(this.projectProgress);

  @override
  List<Object> get props => [projectProgress];
}

final class MonitoringError extends MonitoringState {
  final String message;

  MonitoringError(this.message);

  @override
  List<Object> get props => [message];
}
