part of 'project_bloc.dart';

sealed class ProjectState extends Equatable {
  const ProjectState();

  @override
  List<Object> get props => [];
}

final class ProjectInitial extends ProjectState {}

final class ProjectLoading extends ProjectState {}

final class ProjectLoaded extends ProjectState {
  final ListProjectModel listProjectModel;

  const ProjectLoaded(this.listProjectModel);

  @override
  List<Object> get props => [listProjectModel];
}

final class ProjectDetailLoaded extends ProjectState {
  final DetailProjectResponseModel projectModel;

  const ProjectDetailLoaded(this.projectModel);

  @override
  List<Object> get props => [projectModel];
}

final class ProjectError extends ProjectState {
  final String message;

  const ProjectError(this.message);

  @override
  List<Object> get props => [message];
}
