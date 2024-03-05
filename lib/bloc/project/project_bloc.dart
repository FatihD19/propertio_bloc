import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:propertio_mobile/data/datasource/project_remote_datasource.dart';
import 'package:propertio_mobile/data/model/responses/detail_project_response_model.dart';

import 'package:propertio_mobile/data/model/responses/list_project_response_model.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectInitial()) {
    on<OnGetProject>((event, emit) async {
      emit(ProjectLoading());
      final result = await ProjectRemoteDataSource()
          .getProject(query: event.query, page: event.page, type: event.type);
      result.fold(
        (l) => emit(ProjectError(l)),
        (r) => emit(ProjectLoaded(r)),
      );
    });

    on<OnGetDetailProject>((event, emit) async {
      emit(ProjectLoading());
      final result =
          await ProjectRemoteDataSource().getDetailProject(event.slug);
      result.fold(
        (l) => emit(ProjectError(l)),
        (r) => emit(ProjectDetailLoaded(r)),
      );
    });
  }
}
