import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:propertio_mobile/data/datasource/project_remote_datasource.dart';

import 'package:propertio_mobile/data/model/responses/detail_unit_response_model.dart';

part 'unit_event.dart';
part 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  UnitBloc() : super(UnitInitial()) {
    on<OnGetDetailUnit>((event, emit) async {
      emit(UnitLoading());
      final result =
          await ProjectRemoteDataSource().getDetailUnit(event.idUnit);
      result.fold(
        (l) => emit(UnitError(l)),
        (r) => emit(DetailUnitLoaded(r)),
      );
    });
  }
}
