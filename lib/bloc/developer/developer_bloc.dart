import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_mobile/data/datasource/developer_remote_datasource.dart';
import 'package:propertio_mobile/data/model/responses/detail_developer_response_model.dart';

part 'developer_event.dart';
part 'developer_state.dart';

class DeveloperBloc extends Bloc<DeveloperEvent, DeveloperState> {
  DeveloperBloc() : super(DeveloperInitial()) {
    on<OnGetDetailDeveloper>((event, emit) async {
      emit(DeveloperLoading());
      final result =
          await DeveloperRemoteDataSource().getDetailDeveloper(event.id);
      result.fold(
        (l) => emit(DeveloperError(l)),
        (r) => emit(DeveloperLoaded(r)),
      );
    });

    on<OnGetProjectDeveloper>((event, emit) async {
      emit(DeveloperLoading());
      final result = await DeveloperRemoteDataSource()
          .getDetailDeveloper(event.id, page: event.page);
      result.fold(
        (l) => emit(DeveloperError(l)),
        (r) => emit(ProjectDeveloperLoaded(r.data!.projects!)),
      );
    });
  }
}
