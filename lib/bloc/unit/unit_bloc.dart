import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_bloc/data/datasource/project_remote_datasource.dart';

import 'package:propertio_bloc/data/model/responses/detail_unit_response_model.dart';

part 'unit_event.dart';
part 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  final ProjectRemoteDataSource _projectRemoteDataSource;
  UnitBloc(this._projectRemoteDataSource) : super(UnitInitial()) {
    on<OnGetDetailUnit>((event, emit) async {
      emit(UnitLoading());
      final result = await _projectRemoteDataSource.getDetailUnit(event.idUnit);
      result.fold(
        (l) => emit(UnitError(l)),
        (r) => emit(DetailUnitLoaded(r)),
      );
    });
  }
}
