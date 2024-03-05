part of 'project_bloc.dart';

sealed class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class OnGetProject extends ProjectEvent {
  String? query;
  int? page;
  String? type;

  OnGetProject({this.query, this.page, this.type});

  @override
  List<Object> get props => [
        {query, page, type}
      ];
}

class OnGetDetailProject extends ProjectEvent {
  final String slug;

  const OnGetDetailProject(this.slug);

  @override
  List<Object> get props => [slug];
}
