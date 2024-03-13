import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_mobile/data/datasource/monitoring_remote_datasource.dart';
import 'package:propertio_mobile/data/model/responses/detail_project_progress_response_model.dart';
import 'package:propertio_mobile/data/model/responses/list_projectProgress_response_model.dart';
import 'package:propertio_mobile/data/model/responses/project_progress_page_response_model.dart';

part 'monitoring_event.dart';
part 'monitoring_state.dart';

class MonitoringBloc extends Bloc<MonitoringEvent, MonitoringState> {
  final MonitoringRemoteDataSource remoteDataSource;
  MonitoringBloc(this.remoteDataSource) : super(MonitoringInitial()) {
    on<OnGetProjectProgress>((event, emit) async {
      emit(MonitoringLoading());
      final result = await remoteDataSource.getProjectProgress();
      result.fold(
        (l) => emit(MonitoringError(l)),
        (r) => emit(ProjectProgressLoaded(r)),
      );
    });

    on<OnGetProjectProgressPage>((event, emit) async {
      emit(MonitoringLoading());
      final result = await remoteDataSource.getProjectProgressPage(event.id);
      result.fold(
        (l) => emit(MonitoringError(l)),
        (r) => emit(ProjectProgressPageLoaded(r)),
      );
    });

    on<OnGetDetailProjectProgress>((event, emit) async {
      emit(MonitoringLoading());
      final result = await remoteDataSource.getDetailProjectProgress(event.id);
      result.fold(
        (l) => emit(MonitoringError(l)),
        (r) => emit(DetailProjectProgressLoaded(r)),
      );
    });
  }
}
