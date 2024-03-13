part of 'monitoring_bloc.dart';

sealed class MonitoringEvent extends Equatable {
  const MonitoringEvent();

  @override
  List<Object> get props => [];
}

class OnGetProjectProgress extends MonitoringEvent {}

class OnGetProjectProgressPage extends MonitoringEvent {
  final String id;

  const OnGetProjectProgressPage(this.id);

  @override
  List<Object> get props => [id];
}

class OnGetDetailProjectProgress extends MonitoringEvent {
  final String id;

  const OnGetDetailProjectProgress(this.id);

  @override
  List<Object> get props => [id];
}
