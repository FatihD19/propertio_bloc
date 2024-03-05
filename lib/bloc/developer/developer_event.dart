part of 'developer_bloc.dart';

sealed class DeveloperEvent extends Equatable {
  const DeveloperEvent();

  @override
  List<Object> get props => [];
}

class OnGetDetailDeveloper extends DeveloperEvent {
  final String id;

  const OnGetDetailDeveloper(this.id);

  @override
  List<Object> get props => [id];
}

class OnGetProjectDeveloper extends DeveloperEvent {
  final String id;
  final int page;

  const OnGetProjectDeveloper(this.id, this.page);

  @override
  List<Object> get props => [id, page];
}
